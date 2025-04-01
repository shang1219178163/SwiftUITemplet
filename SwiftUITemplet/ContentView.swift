//
//  ContentView.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2023/8/19.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var router = Router.shared
    
    /// 隐藏 TabBar
    var hideTabBar: Visibility {
        let result = router.path.isEmpty
        return result ? .visible : .hidden
    }

    
    var body: some View {
        TabView(selection: $router.selectedTab) {
            NavigationStack(path: $router.path) {
                TabHomeView()
                    .navigationBarCustom(title: "首页", hideBack: true)

            }
            .toolbar(hideTabBar, for: .tabBar)
            .tabItem {
                Image(systemName: "house.fill")
                Text("首页")
            }
            .tag(0)
            
            NavigationStack(path: $router.path) {
                TabMessageView()
                    .navigationBarCustom(title: "消息", hideBack: true)
            }
            .toolbar(hideTabBar, for: .tabBar)
            .tabItem {
                Image(systemName: "message.fill")
                Text("发现")
            }
            .tag(1)
            
            NavigationStack(path: $router.path) {
                TabFindView()
                    .navigationBarCustom(title: "发现", hideBack: true)
            }
            .toolbar(hideTabBar, for: .tabBar)
            .tabItem {
                Image(systemName: "safari.fill")
                Text("发现")
            }
            .tag(2)
            
            NavigationStack(path: $router.path) {
                TabTestView()
                    .navigationBarCustom(title: "测试", hideBack: true)
            }
            .toolbar(hideTabBar, for: .tabBar)
            .tabItem {
                Image(systemName: "infinity.circle")
                Text("测试")
            }
            .tag(3)
            
            NavigationStack(path: $router.path) {
                TabProfileView()
                    .navigationBarCustom(title: "我的", hideBack: true)
            }
            .toolbar(hideTabBar, for: .tabBar)
            .tabItem {
                Image(systemName: "person.fill")
                Text("我的")
            }
            .tag(4)
            
  
        }

    }
}

#Preview {
    ContentView()
        .environmentObject(Router.shared)
}
