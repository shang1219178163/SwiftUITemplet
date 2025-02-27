//
//  PageView.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/2/26.
//

import SwiftUI
import UIKit

struct PageView<Page: View>: View {
    var viewControllers: [UIHostingController<Page>]
    @State private var currentPage = 0
    
    init(viewControllers: [UIHostingController<Page>], currentPage: Int = 0) {
        self.viewControllers = viewControllers
        self.currentPage = currentPage
    }


    var body: some View {
        PageViewController(controllers: viewControllers, currentPage: $currentPage)
    }
}


// TODO: 待优化
struct PageViewController: UIViewControllerRepresentable {
    var controllers: [UIViewController]
    @Binding var currentPage: Int
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> UIPageViewController {
        let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController.delegate = context.coordinator
        pageViewController.dataSource = context.coordinator
        
        return pageViewController
    }
    
    func updateUIViewController(_ uiViewController: UIPageViewController, context: Context) {
        if let currentVC = controllers[currentPage] as UIViewController? {
            uiViewController.setViewControllers([currentVC], direction: .forward, animated: true, completion: nil)
        }
    }
    
    class Coordinator: NSObject, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
        var parent: PageViewController
        
        init(_ parent: PageViewController) {
            self.parent = parent
        }
        
        
        // DataSource methods
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
            guard let index = parent.controllers.firstIndex(of: viewController) else { return nil }
            let previousIndex = index - 1
            return parent.controllers[previousIndex]
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            guard let index = parent.controllers.firstIndex(of: viewController) else { return nil }
            let nextIndex = index + 1
            return parent.controllers[nextIndex]
        }
        
        // Delegate method to update the current page index
        func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
            if completed, let currentVC = pageViewController.viewControllers?.first,
               let index = parent.controllers.firstIndex(of: currentVC) {
                parent.currentPage = index
            }
        }
    }
    
    
//    class PageContentController<Content: View>: UIHostingController<Content> {
//
//        var index: Int
//
//        init(rootView: Content, index: Int) {
//            self.index = index
//            super.init(rootView: rootView)
//        }
//
//        @MainActor @objc required dynamic init?(coder aDecoder: NSCoder) {
//            fatalError("init(coder:) has not been implemented")
//        }
//
//        override func viewDidLoad() {
//            super.viewDidLoad()
//            view.backgroundColor = .clear
//        }
//
//    }
}
