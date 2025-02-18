//
//  TabbarView.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/2/18.
//

import SwiftUI

struct TabbarView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }

            FeedView()
                .tabItem {
                    Label("Feed", systemImage: "magnifyingglass")
                }
            TestView()
                .tabItem {
                    Label("Test", systemImage: "magnifyingglass")
                }
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
        }
        .accentColor(.blue)
        
    }
}

#Preview {
    TabbarView()
}
