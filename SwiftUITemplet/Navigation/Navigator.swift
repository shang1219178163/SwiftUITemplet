//
//  Navigator.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/2/18.
//

import SwiftUI

protocol Navigator {
    func push(_ view: AnyView, animated: Bool)
    func pop(toRoot: Bool, animated: Bool)
}

protocol NavigatorPresent {

    func present(view: AnyView, animated: Bool);
    func dismiss(animated: Bool);
}



class UIKitNavigator: Navigator, NavigatorPresent {

    private let navigationController: UINavigationController

    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    public func push(_ view: AnyView, animated: Bool = true) {
        let hostingController = UIHostingController(rootView: view)
        navigationController.pushViewController(hostingController, animated: animated)
    }

    public func pop(toRoot: Bool = false, animated: Bool = true) {
        if toRoot {
            navigationController.popToRootViewController(animated: animated)
            return;
        }
        navigationController.popViewController(animated: animated)
    }


    public func present<T: View>(view: T, animated: Bool = true) {
        let vc = UIHostingController(rootView: view)
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .automatic
        navigationController.present(vc, animated: animated)
    }
    
    public func dismiss(animated: Bool) {
        navigationController.dismiss(animated: animated, completion: nil)
    }
    

}


struct SwiftUINavigator: Navigator {
    @Binding var path: NavigationPath

    func push(_ view: AnyView, animated: Bool = true) {
        path.append(HashableAnyView(view: view))
    }

    func pop(toRoot: Bool = false, animated: Bool = true) {
        if toRoot {
            path.removeLast(path.count)
            return;
        }
        path.removeLast()
    }


}



// 定义一个包装类型，包装 AnyView，并且遵循 Hashable 协议
struct HashableAnyView: Hashable {
    var view: AnyView

    // 初始化方法，用于包装任意的 View
    init<V: View>(view: V) {
        self.view = AnyView(view)
    }

    // 为了使其遵循 Hashable 协议，我们需要实现 hash(into:)
    func hash(into hasher: inout Hasher) {
        // 使用 AnyView 的类型信息来生成哈希值
        hasher.combine(String(describing: type(of: view)))
    }

    // 实现符合 Hashable 协议的 == 操作符
    static func == (lhs: HashableAnyView, rhs: HashableAnyView) -> Bool {
        return String(describing: type(of: lhs.view)) == String(describing: type(of: rhs.view))
    }
}

/// 路由
class Router {
    private var navigator: Navigator

    init(navigator: Navigator) {
        self.navigator = navigator
    }

    func to(_ view: AnyView, animated: Bool = true) {
//        if view is AnyView {
//            navigator.push(view as! AnyView, animated: animated)
//            return
//        }
        navigator.push(view, animated: animated)
    }

    func back(toRoot: Bool = false, animated: Bool = true) {
        navigator.pop(toRoot: toRoot, animated: animated)
    }
}
