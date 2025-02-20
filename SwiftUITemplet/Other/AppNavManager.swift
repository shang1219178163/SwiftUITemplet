//
//  AppTabbarController.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/2/20.
//

import Foundation
import SwiftUI

class AppNavManager: ObservableObject {

    static let shared = AppNavManager()  // 静态常量，唯一的实例
    
    private init() {
        // 防止外部创建实例
    }
    
    @Published var path = NavigationPath() // 管理路径的状态

}
