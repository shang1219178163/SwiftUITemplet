//
//  AppTabbarController.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/2/20.
//

import Foundation
import SwiftUI

class NavManager: ObservableObject {

    static let shared = NavManager()  // 静态常量，唯一的实例
    
    private init() {
        // 防止外部创建实例
    }
    
    @State var selectedTab = 0 // 当前选中的标签页索引

    @Published var path = NavigationPath() // 管理路径的状态

//    let paths = [
//        NavigationPath(),
//        NavigationPath(),
//        NavigationPath(),
//        NavigationPath(),
//        NavigationPath()
//    ]
//    
//    @Published private var _path = NavigationPath()
//
//    
//    var path: NavigationPath {
//        get {
//            return paths[selectedTab]
//        }
//        set {
//            _path = newValue
//        }
//    }

//    // 跳转到指定的目标
//    func push<T: Hashable>(_ destination: T) {
//       path.append(destination)
//    }
    
    func push<T: View>(_ destination: T) {
        path.append(HashableAnyView(view: destination))
    }
      
      // 回退
    func pop(toRoot: Bool = false) {
        if toRoot {
            path.removeLast(path.count)
            return;
        }
        path.removeLast()
    }

}
