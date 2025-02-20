//
//  DetailView.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/2/18.
//

import SwiftUI

struct DetailView: View {
    @State private var path = NavigationPath() // 管理路径的状态
    
//    init(path: NavigationPath = NavigationPath()) {
//        self.path = path
//    }

    var body: some View {
        NavigationStack(path: $path) {
            VStack(alignment: .leading, content: {
                Button("Router导航") {
                    let router = Router(navigator: SwiftUINavigator(path: $path));
                    router.to(AnyView(TestView()))
                }
                
                Button( "SwiftUINavigator 导航") {
                    let navigator = SwiftUINavigator(path: $path)
                    navigator.push(AnyView(TestView()))
                }
        
                Button {
                    DDLog("button")
                    path.append(HashableAnyView(view: TestView()))
                } label: {
                    Text("Button")
                }
                
            })
            .padding()
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
    DetailView()
}
