//
//  FeedView.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/2/18.
//

import SwiftUI

struct FeedView: View {
    @State private var path = NavigationPath() // 管理路径的状态

    var body: some View {
        NavigationStack(path: $path) {
            VStack(alignment: .leading, content: {
     
        
                Button {
                    DDLog("button")
                } label: {
                    return Text("Button")
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
    FeedView()
}
