//
//  ContentView.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2023/8/19.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var router = Router.shared
    @State private var showDrawer = false

    /// 隐藏 TabBar
    var hideTabBar: Visibility {
        let result = router.path.isEmpty
        return result ? .visible : .hidden
    }

    
    var body: some View {
        ZStack(alignment: .leading, content: {
            // 主界面内容
             buildTabView()
                .offset(x: showDrawer ? UIScreen.main.bounds.size.width * 0.75 : 0)
                .disabled(showDrawer) // 禁用主界面交互
                .animation(.easeInOut, value: showDrawer)
            

            // 点击遮罩关闭 Drawer
            if showDrawer {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            showDrawer.toggle()
                        }
                    }
            }
             
             // 侧边栏菜单
             if showDrawer {
                 LeftDrawerView(width: UIScreen.main.bounds.size.width * 0.75)
                     .transition(.move(edge: .leading))
             }

            // 顶部菜单按钮
             VStack {
                 if !showDrawer {
                     HStack {
                         Button(action: {
                             withAnimation {
                                 showDrawer.toggle()
                             }
                         }) {
                             Image(systemName: "line.horizontal.3")
                                 .font(.title)
                                 .padding()
                         }
                         Spacer()
                     }
                 }
                Spacer()
            }
        })

    }
        
    
    func buildTabView() -> some View {
        return TabView(selection: $router.selectedTab) {
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
