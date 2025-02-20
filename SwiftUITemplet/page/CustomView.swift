//
//  CustomView.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/2/20.
//

import SwiftUI

/// 自定义页面
struct CustomView: View {
    @State private var path = NavigationPath() // 管理路径的状态
    
    let items = Array(count: 12) { i in
        "选项_\(i)\("z" * i)"
    }
    
    @State private var imageNames = AppResource.image.imageNames

    let columns = [GridItem(.adaptive(minimum: 100))] // 每个元素的最小宽度

    
    var body: some View {
        NavigationStack(path: $path) {
            ScrollView(.vertical, showsIndicators: true) {
                Text("LazyVGrid")
                    .font(.title)
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(imageNames, id: \.self) { e in
                        VStack {
                            Image(e)
                                .resizable()
                                .scaledToFit()
                        }
                    }
                }
                .padding()
                
                Text("RoundedCorner")
                    .font(.title)
                VStack(alignment: .leading, spacing: 10, content: {
                    HStack {
                      Text("SwiftUI")
                          .foregroundColor(.black).font(.title).padding(15)
                          .background(RoundedCorner(color: .green, tr: 30, bl: 30))
                      
                      Text("Lab")
                          .foregroundColor(.black).font(.title).padding(15)
                          .background(RoundedCorner(color: .blue, tl: 30, br: 30))
                      
                    }
                    .padding(20)
                    .border(Color.gray)
                    .shadow(radius: 3)
                    
                    Text("WrapTextView")
                        .font(.title)
                    WrapTextView(items: items, maxWidth: 300)
                        .padding()
                        .border(Color.blue)
                        .background(Color.green)
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

#Preview {
    CustomView()
}

