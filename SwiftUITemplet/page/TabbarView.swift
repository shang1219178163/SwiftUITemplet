//
//  TabbarView.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/2/18.
//

import SwiftUI

struct TabbarView: View {
    @State private var selectedTab = 0 // 当前选中的标签页索引

    var body: some View {
        TabView {
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
        }
        .accentColor(.blue)
        .onChange(of: selectedTab) { newValue in
            // 打印切换的 Tab
            DDLog("\(clsName): \(newValue)")
        }
    }
}

#Preview {
    TabbarView()
}
