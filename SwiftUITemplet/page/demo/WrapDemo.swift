//
//  WrapDemo.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/2/27.
//

import SwiftUI

struct WrapDemo: View {
    @StateObject private var router = Router.shared

    
    var body: some View {
        NavigationStack(path: $router.path) {
            ScrollView(.vertical, showsIndicators: true) {
                
                VStack(alignment: .leading, spacing: 10, content: {
                    Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        alignment: .leading
                    ) {
                        ForEach(0..<20) { i in
                            Text("选项_\(i)\("z" * i)")
                                .padding(EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4))
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                                .onTapGesture { p in
                                    DDLog("onTapGesture: \(i)")
                                }
                        }
                    }.padding(/*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    
                })
            }
            .navigationBar(title: "\(clsName)")
  //            .navigationDestination(for: AppPage<AnyView>.self) { page in
  //                page.makeView()
  //            }
        }
    }
}

#Preview {
    WrapDemo()
}
