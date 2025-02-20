//
//  WrapTextView.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/2/20.
//

import Foundation
import SwiftUI


struct WrapTextView: View {
    /// 字符串集合
    let items: [String]
    /// 最大宽度
    let maxWidth: CGFloat
    let spacing: CGFloat = 8
    let runSpacing: CGFloat = 8

    let padding: EdgeInsets = EdgeInsets(top: 8, leading: 4, bottom: 8, trailing: 4)
    let cornerRadius: CGFloat = 8

    let attrs: [NSAttributedString.Key : Any] = [.font: UIFont.systemFont(ofSize: 17)]
    let backgroundColor: Color = Color.blue
    let foregroundColor: Color = .white


    var body: some View {
       var currentWidth: CGFloat = 0
       var currentRow: [String] = []
       var rows: [[String]] = []

       // 将数据拆分为多行
       for item in items {
           let itemWidth = item.size(withAttributes: attrs).width + padding.leading + padding.trailing;
           if currentWidth + itemWidth > maxWidth {
               rows.append(currentRow)
               currentRow = [item]
               currentWidth = itemWidth
           } else {
               currentRow.append(item)
               currentWidth += itemWidth
           }
       }
       
       if !currentRow.isEmpty {
           rows.append(currentRow)
       }
       
        return VStack(
            alignment: .leading,
            spacing: runSpacing,
            content: {
                ForEach(rows, id: \.self) { row in
                    HStack(spacing: spacing) {
                        ForEach(row, id: \.self) { item in
                            Text(item)
                                .padding(.top, padding.top)
                                .padding(.bottom, padding.bottom)
                                .padding(.leading, padding.leading)
                                .padding(.trailing, padding.trailing)
                                .background(backgroundColor)
                                .foregroundColor(foregroundColor)
                                .cornerRadius(cornerRadius)
                        }
                    }
                }
            }
        )
   }
}
