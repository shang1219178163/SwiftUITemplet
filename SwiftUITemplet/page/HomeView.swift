//
//  HomeView.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/2/18.
//

import SwiftUI

// MARK: - RouterModel
struct RouterModel: Hashable {
    let name: String
    let route: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(route)
    }
    
    static func == (lhs: RouterModel, rhs: RouterModel) -> Bool {
        return lhs.name == rhs.name && lhs.route == rhs.route
    }
}

struct HomeView: View {
    
    @StateObject private var router = Router.shared
    

    /// 系统相关组件
    var systemItems = [
        RouterModel(name: "AnimatePageView", route: AppRouter.animatePage),
        RouterModel(name: "ComponentView", route: AppRouter.component),
        RouterModel(name: "CustomeModifierView", route: AppRouter.customeModifier),
        RouterModel(name: "DynamicContentView", route: AppRouter.dynamicContent),
        RouterModel(name: "GeometryReaderView", route: AppRouter.geometryReader),
        RouterModel(name: "GestureView", route: AppRouter.gesture),
        RouterModel(name: "NavView", route: AppRouter.nav),
    ]
    
    var items = [
        RouterModel(name: "WrapDemo", route: AppRouter.wrap),
        RouterModel(name: "PagerViewDemo", route: AppRouter.pager),
        RouterModel(name: "UnknowView", route: AppRouter.unknow),
        RouterModel(name: "CustomView", route: AppRouter.custom),
        RouterModel(name: "TestView", route: AppRouter.test),
    ]
    
    
    let data: [String] = ["Item 1", "Item 2", "Item 3", "Item 4"]
    
    let avatar: String = "https://yl-prescription-share.oss-cn-beijing.aliyuncs.com/test/message/document/1737078705/im/msg/rec/651722301611577344.jpg";

    var body: some View {
        NavigationStack(path: $router.path) {
            List {
                SystemItemsSection()
                CustomItemsSection()
                
                Button("Button") {
                    DDLog("Button")
                    router.toNamed(AppRouter.detail)
                }
            }
            .listStyle(GroupedListStyle())
            .navigationTitle("\(clsName)")
            .navigationDestination(for: AppPage<AnyView>.self) { page in
                page.makeView()
            }
        }
    }
    
    
    var body1: some View {
           // 使用 NavigationStack 管理导航
           NavigationStack {
               VStack {
                   Text("Home Screen")
                       .font(.largeTitle)
                       .padding()
               }
               .navigationTitle("Home")
               .navigationDestination(for: String.self) { value in
                   if value == "DetailView" {
                       DetailView()
                   }
               }
           
           }
       }
    
    // MARK: - Subviews
    
    private func SystemItemsSection() -> some View {
        Section(header: Text("页面").font(.headline)) {
            ForEach(systemItems, id: \.self) { item in
                RouterItemView(item: item, avatar: avatar)
                    .onTapGesture {
                        DDLog("onTapGesture")
                        router.toNamed(item.route)
                    }
            }
            
            ForEach(items, id: \.self) { item in
                RouterItemView(item: item, avatar: avatar)
                    .onTapGesture {
                        DDLog("onTapGesture")
                        router.toNamed(item.route)
                    }
            }
        }
    }
    
    private func CustomItemsSection() -> some View {
        Section(header: Text("自定义").font(.headline)) {
            CustomOneCell(showArrow: false) {
                Text("CustomOneCell")
            } detail: {
                Text("Subtitle")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
    }
}

// MARK: - RouterItemView
struct RouterItemView: View {
    let item: RouterModel
    let avatar: String
    @StateObject private var router = Router.shared
    
    var body: some View {
        ListItemView(
            avatar: avatar,
            isTitleRightHide: true,
            isSubtitleRightHide: true,
            title: {
                Text(item.name)
            },
            titleRight: {
                Text("titleRight")
                    .font(.body)
            },
            subtitle: {
                Text("")
                    .font(.body)
            },
            subtitleRight: {
                Text("subtitleRight")
                    .font(.body)
            }
        )
        .onTapGesture {
            DDLog("onTapGesture")
            router.toNamed(item.route)
        }
    }
}

#Preview {
    HomeView()
}





