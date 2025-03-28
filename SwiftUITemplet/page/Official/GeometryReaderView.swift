//
//  GeometryReaderView.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/2/19.
//

import SwiftUI

struct GeometryReaderView: View {
       
    @StateObject private var router = Router.shared
    
    
    var body: some View {
        GeometryReader { gr in
        
            let list = [
                "screen: \(UIScreen.main.bounds.toString(1))",
                "global: \(gr.frame(in: .global).toString(1))",
                "local: \(gr.frame(in: .local).toString(1))",
                "custom: \(gr.frame(in: .named("VStack")).toString(1))"];
            
            ZStack {
                Color.blue.opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
             
                
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.blue)
                    .frame(width: gr.size.width * 0.5, height: gr.size.height * 0.5)
                    .position(x: gr.frame(in: .local).midX, y: gr.frame(in: .local).midY)
                    .onTapGesture {
                        print("screen: \(UIScreen.main.bounds)")
                        print("global: \(gr.frame(in: .global))")
                        print("local: \(gr.frame(in: .local))")
                        print("custom: \(gr.frame(in: .named("VStack")))")
                }
                    
                Text("ZStack \(list)")
                    .foregroundColor(.red)
                    .padding()
            }
    
        }



        // 1. 基本 GeometryReader 使用示例
        GeometryReader { g in
            VStack {
                Text("GeometryReader Example \(g.size)")
                    .font(.title3)
                    .lineLimit(5)
                    .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)

                Text("Width: \(g.size.width.toString()), Height: \(g.size.height.toString())")
                    .font(.title3)
                    .background(.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .frame(width: g.size.width * 0.5, height: g.size.height * 0.5)
        }
        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
        
        
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
//        .padding(.vertical, 150)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
        
        // 3. 使用 GeometryReader 实现响应式 UI
        GeometryReader { g in
            VStack {
                Text("Dynamic Position")
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
//        .padding(.vertical, 100)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
        
        // 4. 通过 GeometryReader 进行动画效果
        GeometryReader { g in
            VStack {
                Text("Animating with GeometryReader")
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
//            .frame(height: 400) // 限制 GeometryReader 的高度
        }
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
    
}

#Preview {
    GeometryReaderView()
}




