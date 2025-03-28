//
//  AnimatedSwitchView.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/2/27.
//

import SwiftUI

struct AnimatedSwitchView: View {
    @StateObject private var router = Router.shared

    @State private var showFirstView = true // 控制显示哪个视图
//    @State private var viewSize: CGSize = CGSize(width: 200, height: 100)

    var body: some View {
        NavigationStack(path: $router.path) {
            
            VStack {
                // 切换按钮
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        showFirstView.toggle()
                    }
                }) {
                    Text("切换视图")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                // 动态切换视图
                if showFirstView {
                    FirstView()
                        .transition(
                            .asymmetric(
                                insertion: .scale(scale: 1).combined(with: .opacity), // 插入时放大 + 淡入
                                removal: .scale(scale: 1).combined(with: .opacity) // 移除时放大 + 淡出
                            )
                        )
                } else {
                    SecondView()
                        .transition(
                            .asymmetric(
                                insertion: .scale(scale: 1).combined(with: .opacity), // 插入时放大 + 淡入
                                removal: .scale(scale: 1).combined(with: .opacity) // 移除时放大 + 淡出
                            )
                        )
                }
                
                Text("AnimatedSwitchView")
                Spacer()
            }
            //        .onChange(of: showFirstView) { _ in
            //            withAnimation {
            //                viewSize = showFirstView ? CGSize(width: 150, height: 100) : CGSize(width: 300, height: 200)
            //            }
            //        }
            
            .navigationBar(title: "\(clsName)")
//            .navigationDestination(for: AppPage<AnyView>.self) { page in
//                page.makeView()
//            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// 第一个视图
struct FirstView: View {
    var body: some View {
        Text("这是第一个视图")
            .font(.title)
            .padding()
            .background(Color.green)
            .cornerRadius(10)
//            .frame(maxWidth: 200, maxHeight: 100)
    }
}

// 第二个视图
struct SecondView: View {
    var body: some View {
        Text("这是第二个视图" * 9)
            .font(.title)
            .padding()
            .background(Color.orange)
            .cornerRadius(10)
//            .frame(maxWidth: 300, maxHeight: 150)

    }
}

struct AnimatedSwitchView_Previews: PreviewProvider {
    static var previews: some View {
        AnimatedSwitchView()
    }
}
