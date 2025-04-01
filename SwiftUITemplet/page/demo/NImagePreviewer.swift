

import SwiftUI
import SDWebImageSwiftUI

/// 图片预览器
struct NImagePreviewer: View {
    let images: [String]  // 改为字符串数组，存储图片 URL
    @State private var selectedIndex: Int
    @Binding var isPresented: Bool
    @StateObject private var router = Router.shared
    @State private var isDarkMode: Bool = true
    
    init(images: [String], selectedIndex: Int, isPresented: Binding<Bool>) {
        self.images = images
        self._selectedIndex = State(initialValue: selectedIndex)
        self._isPresented = isPresented
    }
    
    var titleColor: Color {
        return isDarkMode ? .white : .black
    }
    
    var titleDesc: String {
        return "\(selectedIndex + 1)/\(images.count)"
    }
    
    var body: some View {
        NavigationStack(path: $router.path) {
            ZStack {
                Color(isDarkMode ? .black : .white).edgesIgnoringSafeArea(.all)
                
                ImagePagerView(
                    imageUrls: images,
                    selectedIndex: $selectedIndex,
                    isPresented: $isPresented,
                    isDarkMode: isDarkMode,
                    onBack: onBack
                )
            }
            .navigationBarCustom(title: "\(titleDesc)", titleColor: titleColor)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack(content: {
                        Text("\(titleDesc)")
//                           .font(.system(size: 18))
                           .foregroundColor(titleColor)
//                        Text("\(selectedIndex)")
//                            .foregroundColor(titleColor)
                    })
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isDarkMode.toggle()
                    } label: {
                        Image(systemName: isDarkMode ? "sun.max.fill" : "moon.fill")
                            .foregroundColor(titleColor)
                    }
                    .padding(.trailing, 6)
                }
            }
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

#Preview("图片预览") {
    NImagePreviewer(
        images: Resource.image.urls.range(start: 0, end: 9),
        selectedIndex: 3,
        isPresented: .constant(true)
    )
}


struct ImagePagerView: UIViewControllerRepresentable {
    let imageUrls: [String]
    @Binding var selectedIndex: Int
    @Binding var isPresented: Bool
    let isDarkMode: Bool
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
        pageViewController.view.backgroundColor = isDarkMode ? .black : .white
        
        // 设置初始页面
        let initialVC = ImageViewController(
            imageUrl: imageUrls[selectedIndex],
            index: selectedIndex,
            isPresented: $isPresented,
            isDarkMode: isDarkMode
        )
        pageViewController.setViewControllers(
            [initialVC],
            direction: .forward,
            animated: false
        )
        
        return pageViewController
    }
    
    func updateUIViewController(_ pageViewController: UIPageViewController, context: Context) {
        pageViewController.view.backgroundColor = isDarkMode ? .black : .white
        
        if let currentVC = pageViewController.viewControllers?.first as? ImageViewController {
            currentVC.updateBackgroundColor(isDarkMode: isDarkMode)
            
            if currentVC.index != selectedIndex {
                let direction: UIPageViewController.NavigationDirection = selectedIndex > currentVC.index ? .forward : .reverse
                let newVC = ImageViewController(
                    imageUrl: imageUrls[selectedIndex],
                    index: selectedIndex,
                    isPresented: $isPresented,
                    isDarkMode: isDarkMode
                )
                pageViewController.setViewControllers(
                    [newVC],
                    direction: direction,
                    animated: true
                )
            }
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
                imageUrl: parent.imageUrls[newIndex],
                index: newIndex,
                isPresented: parent.$isPresented,
                isDarkMode: parent.isDarkMode
            )
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            guard let imageVC = viewController as? ImageViewController,
                  imageVC.index < parent.imageUrls.count - 1 else { return nil }
            
            let newIndex = imageVC.index + 1
            return ImageViewController(
                imageUrl: parent.imageUrls[newIndex],
                index: newIndex,
                isPresented: parent.$isPresented,
                isDarkMode: parent.isDarkMode
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
    let imageUrl: String
    let index: Int
    @Binding var isPresented: Bool
    private let router = Router.shared
    private var isDarkMode: Bool
    
    private var imageView: UIImageView!
    private var scrollView: UIScrollView!
    private var singleTapGesture: UITapGestureRecognizer!
    private var doubleTapGesture: UITapGestureRecognizer!
    private var panGesture: UIPanGestureRecognizer!
    private var loadingIndicator: UIActivityIndicatorView!
    
    init(imageUrl: String, index: Int, isPresented: Binding<Bool>, isDarkMode: Bool) {
        self.imageUrl = imageUrl
        self.index = index
        self._isPresented = isPresented
        self.isDarkMode = isDarkMode
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadImage()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateImageViewFrame()
        loadingIndicator.center = view.center
    }
    
    func updateBackgroundColor(isDarkMode: Bool) {
        self.isDarkMode = isDarkMode
        view.backgroundColor = isDarkMode ? .black : .white
        scrollView.backgroundColor = isDarkMode ? .black : .white
        loadingIndicator.color = isDarkMode ? .white : .black
    }
    
    private func setupUI() {
        // 设置滚动视图
        scrollView = UIScrollView()
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 3.0
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = isDarkMode ? .black : .white
        view.addSubview(scrollView)
        scrollView.frame = view.bounds
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // 设置图片视图
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        scrollView.addSubview(imageView)
        
        // 设置加载指示器
        loadingIndicator = UIActivityIndicatorView(style: .large)
        loadingIndicator.color = isDarkMode ? .white : .black
        loadingIndicator.hidesWhenStopped = true
        view.addSubview(loadingIndicator)
        loadingIndicator.center = view.center
        loadingIndicator.startAnimating()
        
        // 添加手势
        singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleSingleTap(_:)))
        singleTapGesture.numberOfTapsRequired = 1
        view.addGestureRecognizer(singleTapGesture)
        
        doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(_:)))
        doubleTapGesture.numberOfTapsRequired = 2
        view.addGestureRecognizer(doubleTapGesture)
        
        singleTapGesture.require(toFail: doubleTapGesture)
        
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        panGesture.delegate = self
        view.addGestureRecognizer(panGesture)
        
        // 设置背景色
        updateBackgroundColor(isDarkMode: isDarkMode)
    }
    
    private func loadImage() {
        guard let url = URL(string: imageUrl) else { return }
        
        SDWebImageManager.shared.loadImage(with: url, options: [], progress: nil) { [weak self] (image, _, error, _, _, _) in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.loadingIndicator.stopAnimating()
                
                if let image = image {
                    self.imageView.image = image
                    self.updateImageViewFrame()
                } else {
                    // 显示错误图片或提示
                    self.imageView.image = UIImage(systemName: "exclamationmark.triangle")
                }
            }
        }
    }
    
    private func updateImageViewFrame() {
        guard let image = imageView.image else { return }
        let imageSize = calculateImageSize(for: image)
        imageView.frame = CGRect(origin: .zero, size: imageSize)
        scrollView.contentSize = imageSize
        centerImage()
    }
    
    private func calculateImageSize(for image: UIImage) -> CGSize {
        guard image.size.width > 0, image.size.height > 0 else { return .zero }
        
        let screenSize = view.bounds.size
        let imageRatio = image.size.width / image.size.height
        let screenRatio = screenSize.width / screenSize.height
        
        if imageRatio > screenRatio {
            let width = screenSize.width
            let height = width / imageRatio
            return CGSize(width: width, height: height)
        } else {
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
            return abs(velocity.y) > abs(velocity.x)
        }
        return true
    }
}
