//
//  PagerViewDemo.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/2/26.
//

import SwiftUI

struct PagerViewDemo: View {
    @StateObject private var router = Router.shared

    @State private var hidden = false
    @State private var currentPage = 0
    
    @State private var selection = 0

    
    var body: some View {
        NavigationStack(path: $router.path) {
            VStack(alignment: .leading, 
                   spacing: 10,
                   content: {

                PagerView(0..<20,
                          currentPage: $currentPage,
                          style: .pageCurl
//                          ,navigationOrientation: .vertical
                ) {
                    Text("\($0)")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(content: {
                            Rectangle().fill(Color.random)
                        })
                        .onTapGesture {
                            DDLog("onTapGesture \($currentPage.wrappedValue)")
                            hidden.toggle()
                        }
                }
            })
            .navigationBarCustom(title: "\(clsName)")
  //            .navigationDestination(for: AppPage<AnyView>.self) { page in
  //                page.makeView()
  //            }
        }
    }
}

#Preview {
    PagerViewDemo()
}
