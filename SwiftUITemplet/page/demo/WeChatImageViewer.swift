import SwiftUI

struct WeChatImageViewer: View {
    let images: [UIImage]
    @Binding var selectedIndex: Int
    @Binding var isPresented: Bool
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            ImagePagerView(
                images: images,
                selectedIndex: $selectedIndex,
                isPresented: $isPresented
            )
            
            // 页面指示器
            VStack {
                Spacer()
                Text("\(selectedIndex + 1)/\(images.count)")
                    .foregroundColor(.white)
                    .padding(.bottom, 20)
            }
        }
    }
}

struct ImagePagerView: UIViewControllerRepresentable {
    let images: [UIImage]
    @Binding var selectedIndex: Int
    @Binding var isPresented: Bool
    
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
    
    private var imageView: UIImageView!
    private var scrollView: UIScrollView!
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
    
    private func setupUI() {
        // 设置滚动视图
        scrollView = UIScrollView()
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 3.0
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        view.addSubview(scrollView)
        scrollView.frame = view.bounds
        
        // 设置图片视图
        imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        scrollView.addSubview(imageView)
        
        // 调整图片大小以适应屏幕
        let imageSize = calculateImageSize()
        imageView.frame = CGRect(origin: .zero, size: imageSize)
        scrollView.contentSize = imageSize
        centerImage()
        
        // 添加手势
        doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(_:)))
        doubleTapGesture.numberOfTapsRequired = 2
        view.addGestureRecognizer(doubleTapGesture)
        
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        panGesture.delegate = self
        view.addGestureRecognizer(panGesture)
    }
    
    private func calculateImageSize() -> CGSize {
        let imageRatio = image.size.width / image.size.height
        let screenRatio = view.bounds.width / view.bounds.height
        
        if imageRatio > screenRatio {
            let width = view.bounds.width
            let height = width / imageRatio
            return CGSize(width: width, height: height)
        } else {
            let height = view.bounds.height
            let width = height * imageRatio
            return CGSize(width: width, height: height)
        }
    }
    
    private func centerImage() {
        let offsetX = max((scrollView.bounds.width - imageView.frame.width) / 2, 0)
        let offsetY = max((scrollView.bounds.height - imageView.frame.height) / 2, 0)
        imageView.frame.origin = CGPoint(x: offsetX, y: offsetY)
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