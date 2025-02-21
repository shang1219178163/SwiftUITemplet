//
//  NavigationView.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/2/19.
//

import SwiftUI

/// 页面导航
struct NavView: View {
       //    @State private var path = NavigationPath()
    @StateObject private var navManager = NavManager.shared
    
    // 1. NavigationView 示例状态
    @State private var isNavigationActive = false
    @State private var selectedTab = 0
    
    // 2. Sheet 示例状态
    @State private var isSheetPresented = false
    
    // 3. Alert 示例状态
    @State private var showAlert = false
    
    // 4. Popover 示例状态
    @State private var isPopoverPresented = false

    var body: some View {
        NavigationStack(path: $navManager.path) {
            VStack(alignment: .leading, spacing: 16, content: {
               
                
                 // 1. NavigationView 示例：简单的导航
                 NavigationView {
                     VStack {
                         Text("Tap to navigate to another screen")
                             .padding()
                             .background(Color.blue)
                             .foregroundColor(.white)
                             .cornerRadius(10)
                         
                         NavigationLink("Go to Detail", destination: DetailViewNew())
                             .padding()
                             .background(Color.green)
                             .foregroundColor(.white)
                             .cornerRadius(10)
                     }
                     .navigationTitle("Home")
                     .navigationBarItems(trailing: Button(action: {
                         isNavigationActive = true
                     }) {
                         Text("Go to Details")
                     })
                     .sheet(isPresented: $isNavigationActive) {
                         DetailView()
                     }
                 }
                 .frame(height: 200)  // Set the height of the NavigationView area

                 // 2. TabView 示例：切换不同的标签页
                 TabView(selection: $selectedTab) {
                     Text("First Tab Content")
                         .tabItem {
                             Label("Tab 1", systemImage: "1.circle")
                         }
                         .tag(0)
                     
                     Text("Second Tab Content")
                         .tabItem {
                             Label("Tab 2", systemImage: "2.circle")
                         }
                         .tag(1)
                     
                     Text("Third Tab Content")
                         .tabItem {
                             Label("Tab 3", systemImage: "3.circle")
                         }
                         .tag(2)
                 }
                 .frame(height: 200)
                
                Text("Tab \(selectedTab)")
                
                 // 3. Sheet 示例：模态视图弹出
                 Button("Show Modal Sheet") {
                     isSheetPresented.toggle()
                 }
                 .padding()
                 .background(Color.orange)
                 .foregroundColor(.white)
                 .cornerRadius(10)
                 .sheet(isPresented: $isSheetPresented) {
                     SheetView {
                         isSheetPresented.toggle()
                     }
                 }

                 // 4. Alert 示例：简单弹出警告
                 Button("Show Alert") {
                     showAlert.toggle()
                 }
                 .padding()
                 .background(Color.red)
                 .foregroundColor(.white)
                 .cornerRadius(10)
                 .alert(isPresented: $showAlert) {
                     Alert(
                         title: Text("Important Alert"),
                         message: Text("This is an important message."),
                         dismissButton: .default(Text("OK"))
                     )
                 }
                 
                 // 5. Popover 示例：弹出浮动菜单
                 Button("Show Popover") {
                     isPopoverPresented.toggle()
                 }
                 .padding()
                 .background(Color.purple)
                 .foregroundColor(.white)
                 .cornerRadius(10)
                 .popover(isPresented: $isPopoverPresented) {
                     PopoverView {
                         isPopoverPresented.toggle()
                     }
                 }
                
            })
            .navigationDestination(for: HashableAnyView.self) { view in
               view.view
           }
            .navigationTitle(
                "\(clsName)"
            )
           }
    }
}

#Preview {
    NavView()
}



// Detail View for NavigationLink
struct DetailViewNew: View {
    var body: some View {
        VStack {
            Text("This is the Detail Screen")
                .font(.largeTitle)
                .padding()
            Button("Back") {
                // Custom back action if needed
            }
        }
    }
}

// Sheet View for Modal Presentation
struct SheetView: View {
    var onDismiss: () -> Void

    var body: some View {
        VStack {
            Text("This is a modal sheet view")
                .font(.title)
                .padding()
            Button("Dismiss") {
                onDismiss()
            }
        }
    }
}

// Popover View for Popover Presentation
struct PopoverView: View {
    var onDismiss: () -> Void

    var body: some View {
        VStack {
            Text("This is a Popover view")
                .font(.title)
                .padding()
            Button("Close") {
                onDismiss()
            }
        }
        .frame(width: 200, height: 100)
    }
}
