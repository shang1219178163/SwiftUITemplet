//
//  TextDemoPage.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/2/27.
//

import SwiftUI

struct TextDemoPage: View {
    @StateObject private var router = Router.shared
    
  var body: some View {
      NavigationStack(path: $router.path) {
          ScrollView(.vertical, showsIndicators: true) {
              
              VStack(alignment: .leading, spacing: 10, content: {
                  NSectionView(title: "", desc: "", content: {
                      Text("22号字体, 蓝色, 粗体, 斜体, 间距 10, 黄色背景色")
                          .font(.system(size: 22))
                          .foregroundColor(.blue)
                          .bold()
                          .italic()
                          .padding(10)
                          .background(
                            Rectangle().fill(Color.yellow)
                          )
                  })
                  NSectionView(title: "1. 字体大小", desc: "", content: {
                      ScrollView(.horizontal) {
                          HStack {
                              VStack {
                                  Text("字体(.largeTitle)").font(.largeTitle)
                                  Text("字体(.title)").font(.title)
                                  Text("字体(.title2)").font(.title2)
                                  Text("字体(.title3)").font(.title3)
                                  Text("字体(.headline)").font(.headline)
                                  Text("字体(.subheadline)").font(.subheadline)
                                  Text("字体(.footnote)").font(.footnote)
                                  Text("字体(.caption)").font(.caption)
                                  Text("字体(.caption2)").font(.caption2)
                                  Text("字体(.callout)").font(.callout)
                              }
                              VStack {
                                  Text("字体(28f)").font(.system(size: 28))
                                  Text("字体(26f)").font(.system(size: 26))
                                  Text("字体(24f)").font(.system(size: 24))
                                  Text("字体(22f)").font(.system(size: 22))
                                  Text("字体(20f)").font(.system(size: 20))
                                  Text("字体(18f)").font(.system(size: 18))
                                  Text("字体(16f)").font(.system(size: 16))
                                  Text("字体(14f)").font(.system(size: 14))
                                  Text("字体(12f)").font(.system(size: 12))
                                  Text("字体(10f)").font(.system(size: 10))
                              }
                              VStack {
                                  
                                  Text(".regular").fontWeight(.regular)
                                  Text(".medium").fontWeight(.medium)
                                  Text(".bold").fontWeight(.bold)
                                  Text(".heavy").fontWeight(.heavy)
                                  Text(".light").fontWeight(.light)
                              }
                          }
                          
                          
                      }
                  })
                  NSectionView(title: "2. 阴影效果", desc: "", content: {
                      Text("阴影效果: shadow(color: .black, radius: 2, x: 3, y: 3)")
                          .shadow(color: .black, radius: 2, x: 3, y: 3)
                  })
                  
                  NSectionView(title: "3. 高斯模糊", desc: "", content: {
                      Text("模糊效果: blur(radius: 3)").blur(radius: 3)
                  })
                  
                  NSectionView(title: "4. 横划效果", desc: "", content: {
                      Text("横划效果 strikethrough").strikethrough()
                      Text("横划效果 underline").underline()
                  })
                  
              })
          }
          .navigationBarCustom(title: "\(clsName)")
//            .navigationDestination(for: AppPage<AnyView>.self) { page in
//                page.makeView()
//            }
      }
  }
}

#Preview {
    TextDemoPage()
}
