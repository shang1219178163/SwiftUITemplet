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
                homeTab
                    .navigationBar(title: "首页", hideBack: true)

            }
            .toolbar(hideTabBar, for: .tabBar)
            .tabItem {
                Image(systemName: "house.fill")
                Text("首页")
            }
            .tag(0)
            
            NavigationStack(path: $router.path) {
                discoveryTab
                    .navigationBar(title: "发现", hideBack: true)
            }
            .toolbar(hideTabBar, for: .tabBar)
            .tabItem {
                Image(systemName: "safari.fill")
                Text("发现")
            }
            .tag(1)
            
            NavigationStack(path: $router.path) {
                profileTab
                    .navigationBar(title: "我的", hideBack: true)
            }
            .toolbar(hideTabBar, for: .tabBar)
            .tabItem {
                Image(systemName: "person.fill")
                Text("我的")
            }
            .tag(2)
        }

    }

    private var homeTab: some View {
        List {
            Button("图片预览") {
                if let img_0 = UIImage(named: "IMG_4120"),
                   let img_1 = UIImage(named: "IMG_3736") {
                    router.toNamed(AppRouter.imageViewer, arguments: [
                        "images": [img_0, img_1],
                        "selectedIndex": 0
                    ])
                } else {
                    print("⚠️ 图片加载失败：请确保 'img_0' 和 'img_1' 已添加到 Assets.xcassets 中")
                    // 使用示例图片
                    if let sampleImage = UIImage(systemName: "photo") {
                        router.toNamed(AppRouter.imageViewer, arguments: [
                            "images": [sampleImage, sampleImage],
                            "selectedIndex": 0
                        ])
                    }
                }
            }
            
            Button("设置") {
                router.toNamed(AppRouter.settings)
            }
            
            Button("个人中心") {
                router.toNamed(AppRouter.profile)
            }
            
            Button("详情页") {
                DDLog("详情页")
                router.toNamed(AppRouter.detail, arguments: ["title": "详情页标题"])
            }
        }
    }
    
    private var discoveryTab: some View {
        List {
            ForEach(0..<5) { index in
                Button("发现项目 \(index + 1)") {
                    router.toNamed(AppRouter.discoveryDetail, arguments: [
                        "title": "发现项目 \(index + 1)"
                    ])
                }
            }
        }
    }
    
    private var profileTab: some View {
        List {
            Section {
                HStack {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.gray)
                    
                    VStack(alignment: .leading) {
                        Text("用户名")
                            .font(.headline)
                        Text("查看或编辑个人资料")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    router.toNamed(AppRouter.editProfile)
                }
            }
            
            Section("功能") {
                Button {
                    router.toNamed(AppRouter.collection)
                } label: {
                    Label("我的收藏", systemImage: "star.fill")
                }
                
                Button {
                    router.toNamed(AppRouter.notification)
                } label: {
                    Label("消息通知", systemImage: "bell.fill")
                }
            }
            
            Section {
                Button {
                    router.toNamed(AppRouter.settings)
                } label: {
                    Label("设置", systemImage: "gear")
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(Router.shared)
}

#Preview("图片预览") {
    if let sampleImage = UIImage(systemName: "photo") {
        WeChatImageViewer(
            images: [sampleImage, sampleImage],
            selectedIndex: .constant(0),
            isPresented: .constant(true)
        )
    } else {
        Text("预览不可用")
    }
}
