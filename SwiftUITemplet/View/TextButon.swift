//
//  TextButon.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/2/27.
//

import SwiftUI


/// 自定义按钮
struct TextButon: View {
    var title: String = "TextButon"
    var fontSize: Double = 17
    var textColor: Color = .white
    var backgroundColor: Color = .green
    var cornerRadius: Double = 8
    var borderColor: Color = Color.clear
    var borderWidth: Double = 0
    
    var action: (() -> Void)

    var body: some View {
        Button(action: action, label: {
            Text(title)
                .font(.system(size: fontSize))
                .foregroundColor(textColor)
        })
        .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
        .background(RoundedRectangle(cornerRadius: cornerRadius, style: .circular).fill(backgroundColor))
        .overlay(RoundedRectangle(cornerRadius: cornerRadius).stroke(borderColor, lineWidth: borderWidth))
        .cornerRadius(cornerRadius, antialiased: true)
    }
}

#Preview {
    TextButon(action: {
        DDLog("TextButon")
    })
}
