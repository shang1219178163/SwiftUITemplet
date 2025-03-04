//
//  ProfileView.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/2/18.
//

import SwiftUI

struct ProfileView: View {
       
    @StateObject private var router = Router.shared

    var body: some View {
//        NavigationStack(path: $router.path) {
            VStack(alignment: .leading, content: {
       
                Button {
                    DDLog("button")
                    router.toNamed(AppRouter.settings, arguments: ["a": "aa", "onNext": onNext])
                } label: {
                    return Text("Button")
                }
                
            })
            .padding()
            .navigationBar(title: "\(clsName)")
  //            .navigationDestination(for: AppPage<AnyView>.self) { page in
  //                page.makeView()
  //            }
//           }
    }
    
    func onNext(result: String) -> Void {
        DDLog("result: \(result)")
    }
}

#Preview {
    ProfileView()
}
