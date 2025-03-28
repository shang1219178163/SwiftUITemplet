//
//  CircleLayoutDemo.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/3/14.
//

import SwiftUI

struct CircleLayoutDemo: View {
    @StateObject private var router = Router.shared

    @State private var spacing: CGFloat = 10  // 角度间距
    
    var body: some View {
        NavigationStack(path: $router.path) {
            ScrollView(.vertical, showsIndicators: true) {
                VStack {
                    CircleView(spacing: $spacing)
                    
                    HStack(content: {
                        Slider(value: $spacing, in: 10...50, step: 1)
                             .padding(.top, 10)
                        Text(String(format: "%.2f", $spacing.wrappedValue))
                    })
                    .padding()
                    .navigationBar(title: "\(clsName)")
                    //            .navigationDestination(for: AppPage<AnyView>.self) { page in
                    //                page.makeView()
                    //            }
                }
                
            }
        }
    }
}

#Preview {
    CircleLayoutDemo()
}




