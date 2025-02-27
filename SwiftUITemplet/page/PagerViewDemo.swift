//
//  PagerViewDemo.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/2/26.
//

import SwiftUI

struct PagerViewDemo: View {
    @StateObject private var navManager = NavManager.shared

    @State private var hidden = false
    @State private var currentPage = 0
    
    @State private var selection = 0

    
    var body: some View {
        NavigationStack(path: $navManager.path) {
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
            .navigationDestination(for: HashableAnyView.self) { view in
                view.view
            }
            .navigationTitle(
                "\(clsName)"
            )
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    PagerViewDemo()
}
