//
//  DetailView.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/2/18.
//

import SwiftUI

struct DetailView: View {
       
    @StateObject private var router = Router.shared

//    init(path: NavigationPath = NavigationPath()) {
//        self.path = path
//    }

    var body: some View {
        NavigationStack(path: $router.path) {
            VStack(alignment: .leading, content: {
                Button("Router导航") {
                    let router = Router.shared
                    router.toNamed(AppRouter.detail)
                }
                
                Button( "SwiftUINavigator 导航") {
                    let navigator = SwiftUINavigator(path: $router.path)
                    navigator.push(AnyView(TestView()))
                }
        
                Button {
                    DDLog("button")
                    router.toNamed(AppRouter.detail)
                } label: {
                    Text("Button")
                }
                
            })
            .padding()
            .navigationBar(title: "\(clsName)")
  //            .navigationDestination(for: AppPage<AnyView>.self) { page in
  //                page.makeView()
  //            }
           }
    }
}

#Preview {
    DetailView()
}
