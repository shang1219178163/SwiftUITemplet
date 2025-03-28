//
//  GestureView.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/2/19.
//

import SwiftUI

/// 手势
struct GestureView: View {
       
    @StateObject private var router = Router.shared
    
    // 1. Tap Gesture
    @State private var tapCount = 0
    
    // 2. Drag Gesture
    @State private var dragOffset = CGSize.zero
    
    // 3. Long Press Gesture
    @State private var isPressed = false
    
    // 4. Magnification Gesture (Pinch)
    @State private var magnifyBy = 1.0
    
    // 5. Rotation Gesture
    @State private var rotation: Angle = .zero

    var body: some View {
        NavigationStack(path: $router.path) {
            VStack(alignment: .leading, spacing: 10, content: {
                // 1. Tap Gesture 示例：计数点击次数
                VStack {
                    Text("Tap Count: \(tapCount)")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .onTapGesture {
                            tapCount += 1
                        }
                    Text("Tap anywhere to increment the count")
                        .padding()
                }
                
                // 2. Drag Gesture 示例：拖动视图
                VStack {
                    Text("Drag Me!")
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .offset(dragOffset)
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    dragOffset = value.translation
                                }
                                .onEnded { value in
                                    dragOffset = CGSize.zero // 重置位置
                                }
                        )
                    Text("Drag the box around")
                        .padding()
                }
                
                // 3. Long Press Gesture 示例：长按事件
                VStack {
                    Text(isPressed ? "Long Press Detected!" : "Press and Hold")
                        .padding()
                        .background(isPressed ? Color.green : Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .onLongPressGesture {
                            isPressed.toggle()
                        }
                    Text("Long press the box to change the color")
                        .padding()
                }
                
                // 4. Magnification Gesture 示例：捏合放大缩小
                VStack {
                    Text("Pinch to Scale")
                        .font(.title)
                        .padding()
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .scaleEffect(magnifyBy)
                        .gesture(
                            MagnificationGesture()
                                .onChanged { value in
                                    magnifyBy = value
                                }
                        )
                    Text("Pinch to scale the text size")
                        .padding()
                }
                
                // 5. Rotation Gesture 示例：旋转视图
                VStack {
                    Text("Rotate Me!")
                        .font(.title)
                        .padding()
                        .background(Color.pink)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .rotationEffect(rotation)
                        .gesture(
                            RotationGesture()
                                .onChanged { value in
                                    rotation = value
                                }
                        )
                    Text("Rotate the text by dragging")
                        .padding()
                    
                }
            })
            .navigationBar(title: "\(clsName)")
  //            .navigationDestination(for: AppPage<AnyView>.self) { page in
  //                page.makeView()
  //            }
           }
    }
}

#Preview {
    GestureView()
}
