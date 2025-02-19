//
//  GeometryReaderView.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/2/19.
//

import SwiftUI

struct GeometryReaderView: View {
    @State private var path = NavigationPath() // 管理路径的状态
    
    
    
    var body: some View {
        NavigationStack(path: $path) {
            ScrollView(.vertical, showsIndicators: true) {
                
                VStack(alignment: .leading, spacing: 30, content: {
               
                    HStack {
                          Text("SwiftUI")
                              .foregroundColor(.black).font(.title).padding(15)
                              .background(RoundedCorner(color: .green, tr: 30, bl: 30))
                          
                          Text("Lab")
                              .foregroundColor(.black).font(.title).padding(15)
                              .background(RoundedCorner(color: .blue, tl: 30, br: 30))
                          
                      }
                    .padding(20)
                    .border(Color.gray)
                    .shadow(radius: 3)

            
  
                    // 1. 基本 GeometryReader 使用示例
                    GeometryReader { g in
                        VStack {
                            Text("GeometryReader Example")
                                .font(.title)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .frame(width: .infinity)
                            
                            Text("Width: \(g.size.width.toString()), Height: \(g.size.height.toString())")
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .frame(width: .infinity)
                        }
//                        .frame(height: 400)
                    }
//                    .padding(.vertical, 50)
                    .background(Color.gray.opacity(0.1))
//                    .cornerRadius(10)
                    
                    // 2. 根据 GeometryReader 尺寸改变视图布局
                    GeometryReader { g in
                        VStack {
                            Text("Responsive Layout")
//                                .font(.title)
                                .padding()
                                .background(Color.purple)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                            
                            Rectangle()
                                .fill(Color.orange)
                                .frame(width: g.size.width / 2, height: g.size.height / 4)
                                .cornerRadius(12)
                        }
                    }
                    .padding(.vertical, 150)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    
                    // 3. 使用 GeometryReader 实现响应式 UI
                    GeometryReader { g in
                        VStack {
                            Text("Dynamic Position")
//                                .font(.title)
                                .padding()
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                            
                            Circle()
                                .fill(Color.yellow)
                                .frame(width: 100, height: 100)
                                .position(x: g.size.width / 2, y: g.size.height / 2) // 中心位置
                        }
//                        .frame(height: 400)
                    }
                    .padding(.vertical, 100)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    
                    // 4. 通过 GeometryReader 进行动画效果
                    GeometryReader { g in
                        VStack {
                            Text("Animating with GeometryReader")
//                                .font(.title)
                                .padding()
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                            
                            Circle()
                                .fill(Color.blue)
                                .frame(width: 100, height: 100)
                                .position(x: g.size.width / 2, y: g.size.height / 4)
                                .animation(.easeInOut(duration: 2), value: g.size.width)
                        }
                        .frame(height: 400) // 限制 GeometryReader 的高度
                    }
//                    .padding(.vertical, 100)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
               
                    
                })
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
    GeometryReaderView()
}




