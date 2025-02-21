//
//  TabbarView.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/2/18.
//

import SwiftUI

struct TabbarView: View {
    
//       //    @State private var path = NavigationPath()
    @StateObject private var navManager = NavManager.shared

    @State private var selectedTab = 0 // 当前选中的标签页索引

    var body: some View {
        TabView(selection: $selectedTab, content: {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag(0)
            
            FeedView()
                .tabItem {
                    Label("Feed", systemImage: "magnifyingglass")
                }
                .tag(1)
            
            TestView()
                .tabItem {
                    Label("Test", systemImage: "gearshape.fill")
                }
                .tag(2)
     
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
                .tag(3)
        })
        .accentColor(.blue)
    }
}

#Preview {
    TabbarView()
}


class AppNavigationModel: ObservableObject {
    @Published var navigationPath = NavigationPath() // 用于保存导航路径
}


struct AppRouterModel: Hashable {

    /// 页面路由
    var name: String;
    /// 页面参数
    var argments: [String: Any] = [:]
    
    
    // 为了使其遵循 Hashable 协议，我们需要实现 hash(into:)
    func hash(into hasher: inout Hasher) {
        // 使用 AnyView 的类型信息来生成哈希值
        let result = [name, "\(argments)"].joined(separator: ",")
        hasher.combine(result)
    }
    
    static func == (lhs: AppRouterModel, rhs: AppRouterModel) -> Bool {
        return lhs.name == rhs.name;
    }
}
