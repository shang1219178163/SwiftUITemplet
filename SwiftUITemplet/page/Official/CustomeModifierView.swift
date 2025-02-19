//
//  ViewModifiersView.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/2/19.
//

import SwiftUI


// 1. 创建自定义视图修饰符
struct Decoration: ViewModifier {
    var textColor: Color = .black
    var backgroundColor: Color = .clear
    var cornerRadius: CGFloat = 10
    var shadowRadius: CGFloat = 5
    
    func body(content: Content) -> some View {
        content
            .padding()
            .background(backgroundColor)
            .foregroundColor(textColor)
            .cornerRadius(cornerRadius)
            .shadow(radius: shadowRadius)
    }
}

// 2. 扩展 View 以便轻松使用自定义修饰符
extension View {
    func decoration(textColor: Color = Color.black,
                    backgroundColor: Color = .clear,
                    cornerRadius: CGFloat = 10,
                    shadowRadius: CGFloat = 5) -> some View {
        self.modifier(Decoration(
            textColor: textColor,
            backgroundColor: backgroundColor, 
            cornerRadius: cornerRadius,
            shadowRadius: shadowRadius))
    }
}

/// 自定义视图修饰符
struct CustomeModifierView: View {
    @State private var path = NavigationPath() // 管理路径的状态
    
    @State private var showText = true

    
    var body: some View {
        NavigationStack(path: $path) {
            ScrollView(.vertical, showsIndicators: true) {
                
                VStack(alignment: .leading, spacing: 10, content: {
                    
                    Text("Text - modifier")
                        .modifier(Decoration(
                            textColor: .white,
                            backgroundColor: .green,
                             cornerRadius: 20,
                             shadowRadius: 8))
                                 
                    
                    // 4. 按钮样式应用于按钮
                      Button(action: {
                          showText.toggle()
                      }) {
                          Text("Button - decoration")
                              .decoration(
                                textColor: .white,
                                backgroundColor: .green,
                                 cornerRadius: 20,
                                 shadowRadius: 8)
                      }
                })
                .frame(width: .infinity)
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
    CustomeModifierView()
}
