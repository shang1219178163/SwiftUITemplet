//
//  ImageGridView.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/2/20.
//

import SwiftUI

/// 九宫格图片
struct ImageGridView: View {
    let images: [String]
    let spacing: CGFloat = 10
    let radius: CGFloat = 8

    /// 每行最多显示个数
    let rowCount: Int = 4
    
    var onTap: (Int) -> Void

    
    var itemWidth: CGFloat {
        let maxWidth: CGFloat = UIScreen.main.bounds.width -  CGFloat((rowCount - 1)) * spacing
        let width: CGFloat = ceil(maxWidth / CGFloat(rowCount))
        return width;
    }
    
    var body: some View {
        let columns = Array(repeating: GridItem(.flexible()), count: rowCount)
        LazyVGrid(columns: columns, spacing: spacing) {
            ForEach(images, id: \.self) { imageURL in
                AsyncImage(url: URL(string: imageURL)) { phase in
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
                            .onTapGesture {
                                if let index = images.firstIndex(of: imageURL) {
                                    onTap(index)
                                }
                            }
                    case .failure:
                        Image(systemName: "xmark.circle.fill") // 显示错误图标
                            .frame(width: itemWidth, height: itemWidth)
                            .foregroundColor(.red)
                            .cornerRadius(radius)
                    @unknown default:
                        EmptyView()
                    }
                }
            }
        }
    }
}
