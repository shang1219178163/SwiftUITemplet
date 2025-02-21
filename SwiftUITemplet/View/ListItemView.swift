//
//  ListItemView.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/2/20.
//

import SwiftUI

/// List 子项
struct ListItemView<TitleView: View, TitleRightView: View, SubtitleView: View, SubtitleRightView: View>: View {
    
    var avatar: String
    var avatarSize: CGFloat = 48.0
    var avatarRadius: CGFloat = 8.0
    
    var isTitleRightHide: Bool = false
    var isSubtitleHide: Bool = false
    var isSubtitleRightHide: Bool = false
    var isArrowHide: Bool = false

    var title: () -> TitleView
    var titleRight: () -> TitleRightView
    var subtitle: () -> SubtitleView
    var subtitleRight: () -> SubtitleRightView

    init(
        avatar: String,
        avatarSize: CGFloat = 48.0,
        avatarRadius: CGFloat = 8.0,
        isTitleRightHide: Bool = false,
        isSubtitleHide: Bool = false,
        isSubtitleRightHide: Bool = false,
        isArrowHide: Bool = false,
        @ViewBuilder title: @escaping () -> TitleView,
        @ViewBuilder titleRight: @escaping () -> TitleRightView,
        @ViewBuilder subtitle: @escaping () -> SubtitleView,
        @ViewBuilder subtitleRight: @escaping () -> SubtitleRightView
    ) {
        self.avatar = avatar
        self.avatarSize = avatarSize
        self.avatarRadius = avatarRadius
        
        self.isTitleRightHide = isTitleRightHide
        self.isSubtitleHide = isSubtitleHide
        self.isSubtitleRightHide = isSubtitleRightHide
        self.isArrowHide = isArrowHide
        self.title = title
        self.titleRight = titleRight
        self.subtitle = subtitle
        self.subtitleRight = subtitleRight
    }
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: avatar)) { phase in
                switch phase {
                case .empty:
                    ProgressView() // 加载时显示进度条
                        .frame(width: avatarSize, height: avatarSize)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(avatarRadius)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: avatarSize, height: avatarSize)
                        .cornerRadius(avatarRadius)
                        .clipped()
                     
                case .failure:
                    Image(systemName: "xmark.circle.fill") // 显示错误图标
                        .frame(width: avatarSize, height: avatarSize)
                        .foregroundColor(.red)
                        .cornerRadius(avatarRadius)
                @unknown default:
                    EmptyView()
                }
            }.padding(.trailing, 10)
            
            VStack(alignment: .leading,
                   content:  {
                HStack(alignment: .center,
                       content: {
                    title()
                    if !isTitleRightHide {
                        Spacer()
                        titleRight()
                    }
                })
                HStack(alignment: .center,
                       content: {
                    
                    if !isSubtitleHide {
                        subtitle()
                    }
               
                    if !isSubtitleRightHide {
                        Spacer()
                        subtitleRight()
                    }
                })
                
            })
            
            Spacer()
            if !isArrowHide {
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
        }
    }
}




struct CustomOneCell<Content: View, Detail: View>: View {
    var showArrow: Bool
    var content: () -> Content
    var detail: () -> Detail
    
    init(showArrow: Bool = true,
         @ViewBuilder content: @escaping () -> Content,
         @ViewBuilder detail: @escaping () -> Detail
    ) {
        self.showArrow = showArrow
        self.content = content
        self.detail = detail
    }
    
    var body: some View {
        HStack {
            content()
            Spacer()
            detail()
            if showArrow {
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 2)
    }
}
