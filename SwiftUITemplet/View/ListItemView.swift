//
//  ListItemView.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/2/20.
//

import SwiftUI

/// List 子项
struct ListItemView<Content: View>: View {
    var avatar: String
    @ViewBuilder var title: () -> Content
    @ViewBuilder var titleRight: () -> Content

    @ViewBuilder var subtitle: () -> Content
    @ViewBuilder var subtitleRight: () -> Content

    var itemWidth: CGFloat = 48.0
    var radius: CGFloat = 8.0
    
    init(avatar: String, title: @escaping () -> Content, titleRight: @escaping () -> Content, subtitle: @escaping () -> Content, subtitleRight: @escaping () -> Content, itemWidth: CGFloat = 48, radius: CGFloat = 8) {
        self.avatar = avatar
   
        self.title = title
        self.titleRight = titleRight
        self.subtitle = subtitle
        self.subtitleRight = subtitleRight
        self.itemWidth = itemWidth
        self.radius = radius
    }

    
    var body: some View {
        VStack(alignment: .leading,
               content: {
            HStack(content: {
                AsyncImage(url: URL(string: avatar)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView() // 加载时显示进度条
                            .frame(width: itemWidth, height: itemWidth)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(radius)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: itemWidth, height: itemWidth)
                            .cornerRadius(radius)
                            .clipped()
                         
                    case .failure:
                        Image(systemName: "xmark.circle.fill") // 显示错误图标
                            .frame(width: itemWidth, height: itemWidth)
                            .foregroundColor(.red)
                            .cornerRadius(radius)
                    @unknown default:
                        EmptyView()
                    }
                }
                
                VStack(alignment: .leading,
                       content:  {
                    HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/,
                           content: {
                        title()
                        Spacer()
                        titleRight()
                        
                    })
                    HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/,
                           content: {
                        subtitle()
                        Spacer()
                        subtitleRight()
                    })
                    
                })
                // 向右箭头
              Image(systemName: "chevron.right")
                  .resizable()
                  .frame(width: 8, height: 12)
                  .padding(.leading, 4)
            })
        })
    }
}
