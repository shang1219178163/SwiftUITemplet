//
//  WrapViewDemo.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/2/27.
//

import SwiftUI


struct WrapDemo: View {
    //    @State private var path = NavigationPath()
    @StateObject private var navManager = NavManager.shared
    
    
    
    var body: some View {
        NavigationStack(path: $navManager.path) {
            ScrollView(.vertical, showsIndicators: true) {
                
                VStack(alignment: .leading, 
                       spacing: 10,
                       content: {
                    Wrap(spacing: 10,
                        runSpacing: 10,
                        alignment: .leading) {
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
                    }
                    .padding(16)
                    
                })
            }
            .navigationDestination(for: HashableAnyView.self) { view in
                view.view
            }
            .navigationTitle(
                "\(clsName)"
            )
        }
    }

}

struct WrapDemo_Previews: PreviewProvider {
    static var previews: some View {
        WrapDemo()
    }
}
