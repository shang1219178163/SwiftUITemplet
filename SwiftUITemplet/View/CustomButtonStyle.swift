//
//  CustomButtonStyle.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/3/28.
//

import SwiftUI

struct CustomButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(EdgeInsets(
                top: 10,
                leading: 10,
                bottom: 10,
                trailing: 10
            ))
            .background(configuration.isPressed ? Color.gray : Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0) // 按下时缩小
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    }
}
