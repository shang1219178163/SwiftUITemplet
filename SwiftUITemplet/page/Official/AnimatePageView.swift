//
//  ComponentView.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/2/19.
//

import SwiftUI

/// 基础动画效果
struct AnimatePageView: View {
    
       
    @StateObject private var router = Router.shared

    // 1. 基础动画：改变视图大小
    @State private var isExpanded = false
   
    // 2. 显式动画：旋转图标
    @State private var rotation: Double = 0
   
    // 3. 过渡动画：淡入淡出
    @State private var showText = false
   
    // 4. 缩放动画：按钮点击时视图缩放
    @State private var scale: CGFloat = 1
   
    // 5. 位移动画：滑动视图
    @State private var offset: CGFloat = 0
    
    
    var body: some View {
        NavigationStack(path: $router.path) {
            
            // ScrollView
            ScrollView(.vertical, showsIndicators: true) {
                VStack(alignment: .leading, spacing: 10, content: {
                    
                    // 1. 基础动画：改变视图大小
                    VStack {
                        Text("Tap to Animate (Size)")
                            .padding()
                            .background(isExpanded ? Color.blue : Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(isExpanded ? 15 : 5)
                            .frame(width: isExpanded ? 200 : 100, height: isExpanded ? 100 : 50)
                            .animation(.easeInOut(duration: 1), value: isExpanded)
                        
                        Button("Toggle Size") {
                            isExpanded.toggle()
                        }
                        .padding()
                    }
                    
                    // 2. 显式动画：旋转图标
                    VStack {
                        Image(systemName: "arrow.right.circle.fill")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .rotationEffect(.degrees(rotation))
                            .animation(.easeInOut(duration: 1), value: rotation)
                        
                        Button("Rotate \(rotation.toString(0))") {
                            rotation += 90
                        }
                        .padding()
                    }
                    
                    // 3. 过渡动画：淡入淡出
                    VStack {
                        if showText {
                            Text("Hello, World!")
                                .padding()
                                .background(Color.green)
                                .foregroundColor(.white)
                                .transition(.opacity)  // 淡入淡出过渡
                                .animation(.easeInOut(duration: 1), value: showText)
                        }
                        
                        Button("Toggle Text") {
                            showText.toggle()
                        }
                        .padding()
                    }
                    
                    // 4. 缩放动画：按钮点击时视图缩放
                    VStack {
                        Image(systemName: "star.fill")
                            .resizable()
                            .frame(width: scale == 1 ? 50 : 100)
                            .scaleEffect(scale)
                            .animation(.easeInOut(duration: 1), value: scale)
                        
                        Button("Scale") {
                            scale = scale == 1 ? 1.5 : 1
                        }
                        .padding()
                    }
                    
                    // 5. 位移动画：滑动视图
                    VStack {
                        Text("Swipe Me!")
                            .padding()
                            .background(Color.orange)
                            .foregroundColor(.white)
                            .offset(x: offset)
                            .animation(.easeInOut(duration: 1), value: offset)
                        
                        Button("Move Right") {
                            if offset == 100 {
                                offset = 0
                            } else {
                                offset += 100
                            }
                        
                        }
                        .padding()
                    }
                })
                .frame(maxWidth: .infinity)
            }
            .navigationBar(title: "\(clsName)")
  //            .navigationDestination(for: AppPage<AnyView>.self) { page in
  //                page.makeView()
  //            }
       }
    }
    
}


#Preview {
    AnimatePageView()
}
