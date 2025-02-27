//
//  PagerView.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/2/26.
//

import SwiftUI

struct PagerView<Data: RandomAccessCollection, Page: View>: UIViewControllerRepresentable {

    private let data: Data
    
    @Binding var currentPage: Data.Index
    
    private let interPageSpacing: CGFloat
    
    private let style: UIPageViewController.TransitionStyle
    
    private let navigationOrientation: UIPageViewController.NavigationOrientation
    
    private let content: (Data.Element) -> Page

    init(
        _ data: Data,
        currentPage: Binding<Data.Index>,
        interPageSpacing: CGFloat = 0,
        style: UIPageViewController.TransitionStyle = .scroll, navigationOrientation: UIPageViewController.NavigationOrientation = .horizontal,
        @ViewBuilder content: @escaping (Data.Element) -> Page
    ) {
        self.data = data
        self._currentPage = currentPage
        self.interPageSpacing = interPageSpacing
        self.style = style
        self.navigationOrientation = navigationOrientation
        self.content = content
    }

    func makeUIViewController(context: Context) -> UIPageViewController {
        let pageViewController = UIPageViewController(
            transitionStyle: style,
            navigationOrientation: navigationOrientation,
            options: [.interPageSpacing: interPageSpacing]
        )
        pageViewController.delegate = context.coordinator
        pageViewController.dataSource = context.coordinator
        return pageViewController
    }

    func updateUIViewController(_ uiViewController: UIPageViewController, context: Context) {
        let direction: UIPageViewController.NavigationDirection

        if let previousViewController = uiViewController.viewControllers?.first as? PageContentController<Page> {
            guard previousViewController.index != currentPage else { return }
            direction = previousViewController.index < currentPage ? .forward : .reverse
        } else {
            direction = .forward
        }

        let page = context.coordinator.page(for: currentPage)
        uiViewController.setViewControllers([page], direction: direction, animated: true)
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    class Coordinator: NSObject, UIPageViewControllerDelegate, UIPageViewControllerDataSource {

        private var parent: PagerView

        init(_ parent: PagerView) {
            self.parent = parent
        }

        func page(for index: Data.Index) -> PageContentController<Page> {
            return PageContentController(rootView: parent.content(parent.data[index]), index: index)
        }

        func pageViewController(
            _ pageViewController: UIPageViewController,
            viewControllerBefore viewController: UIViewController
        ) -> UIViewController? {
            guard parent.currentPage > parent.data.startIndex else { return nil }
            return page(for: parent.data.index(parent.currentPage, offsetBy: -1))
        }

        func pageViewController(
            _ pageViewController: UIPageViewController,
            viewControllerAfter viewController: UIViewController
        ) -> UIViewController? {
            guard parent.currentPage < parent.data.index(parent.data.endIndex, offsetBy: -1) else { return nil }
            return page(for: parent.data.index(parent.currentPage, offsetBy: 1))
        }

        func pageViewController(
            _ pageViewController: UIPageViewController,
            didFinishAnimating finished: Bool,
            previousViewControllers: [UIViewController],
            transitionCompleted completed: Bool
        ) {
            if completed, let viewController = pageViewController.viewControllers?.first as? PageContentController<Page> {
                parent.currentPage = viewController.index
            }
        }

    }

    class PageContentController<Content: View>: UIHostingController<Content> {

        var index: Data.Index

        init(rootView: Content, index: Data.Index) {
            self.index = index
            super.init(rootView: rootView)
        }

        @MainActor @objc required dynamic init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .clear
        }

    }

}
