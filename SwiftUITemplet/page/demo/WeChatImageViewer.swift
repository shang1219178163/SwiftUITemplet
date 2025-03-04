import SwiftUI

struct WeChatImageViewer: View {
    let images: [UIImage]
    @Binding var selectedIndex: Int
    @Binding var isPresented: Bool
    @StateObject private var router = Router.shared
    
    
    var body: some View {
        NavigationStack(path: $router.path) {
            
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                
                ImagePagerView(
                    images: images,
                    selectedIndex: $selectedIndex,
                    isPresented: $isPresented,
                    onBack: onBack
                )
            }
            .navigationBar(title: "\(selectedIndex + 1)/\(images.count)")
//            .navigationDestination(for: AppPage<AnyView>.self) { page in
//                page.makeView()
//            }
            .onAppear {
                router.isPresented = true
                DDLog("onAppear \(router.path == router.path)")
            }.onDisappear(perform: {
                DDLog("onDisappear \(router.path == router.path)")
            })
        }
    }
    
    
    func onBack() -> Void {
        router.back()
    }
}

struct ImagePagerView: UIViewControllerRepresentable {
    let images: [UIImage]
    @Binding var selectedIndex: Int
    @Binding var isPresented: Bool
    let onBack: () -> Void

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> UIPageViewController {
        let pageViewController = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal
        )
        pageViewController.dataSource = context.coordinator
        pageViewController.delegate = context.coordinator
        
        // 设置初始页面
        let initialVC = ImageViewController(
            image: images[selectedIndex],
            index: selectedIndex,
            isPresented: $isPresented
        )
        pageViewController.setViewControllers(
            [initialVC],
            direction: .forward,
            animated: false
        )
        
        return pageViewController
    }
    
    func updateUIViewController(_ pageViewController: UIPageViewController, context: Context) {
        if let currentVC = pageViewController.viewControllers?.first as? ImageViewController,
           currentVC.index != selectedIndex {
            let direction: UIPageViewController.NavigationDirection = selectedIndex > currentVC.index ? .forward : .reverse
            let newVC = ImageViewController(
                image: images[selectedIndex],
                index: selectedIndex,
                isPresented: $isPresented
            )
            pageViewController.setViewControllers(
                [newVC],
                direction: direction,
                animated: true
            )
        }
    }
    
    class Coordinator: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
        var parent: ImagePagerView
        
        init(_ parent: ImagePagerView) {
            self.parent = parent
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
            guard let imageVC = viewController as? ImageViewController,
                  imageVC.index > 0 else { return nil }
            
            let newIndex = imageVC.index - 1
            return ImageViewController(
                image: parent.images[newIndex],
                index: newIndex,
                isPresented: parent.$isPresented
            )
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            guard let imageVC = viewController as? ImageViewController,
                  imageVC.index < parent.images.count - 1 else { return nil }
            
            let newIndex = imageVC.index + 1
            return ImageViewController(
                image: parent.images[newIndex],
                index: newIndex,
                isPresented: parent.$isPresented
            )
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
            if completed,
               let imageVC = pageViewController.viewControllers?.first as? ImageViewController {
                parent.selectedIndex = imageVC.index
            }
        }
    }
}

class ImageViewController: UIViewController {
    let image: UIImage
    let index: Int
    @Binding var isPresented: Bool
    private let router = Router.shared
    
    private var imageView: UIImageView!
    private var scrollView: UIScrollView!
    private var singleTapGesture: UITapGestureRecognizer!
    private var doubleTapGesture: UITapGestureRecognizer!
    private var panGesture: UIPanGestureRecognizer!
    
    init(image: UIImage, index: Int, isPresented: Binding<Bool>) {
        self.image = image
        self.index = index
        self._isPresented = isPresented
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateImageViewFrame()
    }
    
    private func setupUI() {
        // 设置滚动视图
        scrollView = UIScrollView()
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 3.0
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .black
        view.addSubview(scrollView)
        scrollView.frame = view.bounds
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // 设置图片视图
        imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        scrollView.addSubview(imageView)
        
        // 调整图片大小以适应屏幕
        updateImageViewFrame()
        
        // 添加手势
        singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleSingleTap(_:)))
        singleTapGesture.numberOfTapsRequired = 1
        view.addGestureRecognizer(singleTapGesture)
        
        doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(_:)))
        doubleTapGesture.numberOfTapsRequired = 2
        view.addGestureRecognizer(doubleTapGesture)
        
        // 确保单击手势不会与双击手势冲突
        singleTapGesture.require(toFail: doubleTapGesture)
        
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        panGesture.delegate = self
        view.addGestureRecognizer(panGesture)
    }
    
    private func updateImageViewFrame() {
        let imageSize = calculateImageSize()
        imageView.frame = CGRect(origin: .zero, size: imageSize)
        scrollView.contentSize = imageSize
        centerImage()
    }
    
    private func calculateImageSize() -> CGSize {
        guard image.size.width > 0, image.size.height > 0 else { return .zero }
        
        let screenSize = view.bounds.size
        let imageRatio = image.size.width / image.size.height
        let screenRatio = screenSize.width / screenSize.height
        
        if imageRatio > screenRatio {
            // 图片更宽，以屏幕宽度为准
            let width = screenSize.width
            let height = width / imageRatio
            return CGSize(width: width, height: height)
        } else {
            // 图片更高，以屏幕高度为准
            let height = screenSize.height
            let width = height * imageRatio
            return CGSize(width: width, height: height)
        }
    }
    
    private func centerImage() {
        let boundsSize = scrollView.bounds.size
        var frameToCenter = imageView.frame
        
        if frameToCenter.size.width < boundsSize.width {
            frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width) / 2
        } else {
            frameToCenter.origin.x = 0
        }
        
        if frameToCenter.size.height < boundsSize.height {
            frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height) / 2
        } else {
            frameToCenter.origin.y = 0
        }
        
        imageView.frame = frameToCenter
    }
    
    @objc private func handleSingleTap(_ gesture: UITapGestureRecognizer) {
        router.back()
    }
    
    @objc private func handleDoubleTap(_ gesture: UITapGestureRecognizer) {
        if scrollView.zoomScale > 1.0 {
            scrollView.setZoomScale(1.0, animated: true)
        } else {
            let location = gesture.location(in: imageView)
            let rect = CGRect(x: location.x - 50, y: location.y - 50, width: 100, height: 100)
            scrollView.zoom(to: rect, animated: true)
        }
    }
    
    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
        guard scrollView.zoomScale == 1.0 else { return }
        
        let translation = gesture.translation(in: view)
        
        switch gesture.state {
        case .changed:
            let scale = abs(translation.y) / view.bounds.height
            view.transform = CGAffineTransform(translationX: 0, y: translation.y)
            view.alpha = 1 - scale
            
        case .ended:
            let velocity = gesture.velocity(in: view)
            if abs(translation.y) > 100 || abs(velocity.y) > 500 {
                UIView.animate(withDuration: 0.2) {
                    self.view.transform = CGAffineTransform(translationX: 0, y: translation.y > 0 ? 1000 : -1000)
                    self.view.alpha = 0
                } completion: { _ in
                    self.isPresented = false
                }
            } else {
                UIView.animate(withDuration: 0.2) {
                    self.view.transform = .identity
                    self.view.alpha = 1
                }
            }
            
        default:
            break
        }
    }
}

extension ImageViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        centerImage()
    }
}

extension ImageViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == panGesture {
            let velocity = panGesture.velocity(in: view)
            // 只有垂直滑动时才处理手势
            return abs(velocity.y) > abs(velocity.x)
        }
        return true
    }
} 
