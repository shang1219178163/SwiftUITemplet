////
////  NavigationContext.swift
////  SwiftUITemplet
////
////  Created by Bin Shang on 2025/2/18.
////
//
//import Foundation
//import SwiftUI
//
//
//public protocol Route {}
//
//public protocol Coordinator: AnyObject{
//    func naviagtion(to route: Route);
//}
//
//
//public protocol NavigationContext{
//    func setInitalView<T: View>(view: T,
//                                onViewIsAppearing: (() -> Void)?,
//                                onViewDidDisappear: (() -> Void)?);
//    func push<T: View>(view: T, animated: Bool);
//    func pop(animated: Bool);
//    func present<T: View>(view: T, animated: Bool);
//    func dismiss(animated: Bool);
//}
//
//
//public class MyNavigationController: UINavigationController, NavigationContext{
//    public func setInitalView<T: View>(view: T,
//                                 onViewIsAppearing: (() -> Void)?,
//                                 onViewDidDisappear: (() -> Void)?) {
//        let vc = UIHostingController(rootView: view)
//        onViewIsAppearing?();
//        viewControllers = [vc]
//        onViewDidDisappear?();
//    }
//    
//    public func push<T: View>(view: T, animated: Bool) {
//        let vc = UIHostingController(rootView: view)
//        pushViewController(vc, animated: animated)
//    }
//    
//    public func pop(animated: Bool) {
//        popViewController(animated: animated)
//    }
//    
//    public func present<T: View>(view: T, animated: Bool) {
//        let vc = UIHostingController(rootView: view)
//        vc.modalTransitionStyle = .coverVertical
//        vc.modalPresentationStyle = .automatic
//        present(vc, animated: animated)
//    }
//    
//    public func dismiss(animated: Bool) {
//        dismiss(animated: animated, completion: nil)
//    }
//    
//    
//}
//
//
///// 此协议则是对 UITabBarController 功能的抽象，通常你的应用中仅会有一个这样的控制器，由 AppCoordinator 负责管理。
//public protocol NavigationRoot{
//    func setTabs(to navigation: [NavigationContext])
//    func swithTo(tabIndex: Int)
//    func present(navContext: NavigationContext, animated: Bool)
//}
//
//
//final class MyHostingController<Content>: UIHostingController<Content> where Content: View {
//    var onViewIsAppearing: (() -> Void)?
//    var onViewDidDisappear: (() -> Void)?
//    
//    convenience init(rootView: Content,
//                     onViewIsAppearing: (() -> Void)?,
//                     onViewDidDisappear: (() -> Void)?) {
//        self.init(rootView: rootView)
//        self.onViewIsAppearing = onViewIsAppearing
//        self.onViewDidDisappear = onViewDidDisappear
//    }
//
//}
//
//
////final class MyNavigationController: UINavigationController, {}
//
