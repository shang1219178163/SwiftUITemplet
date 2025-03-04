//
//  SheetDemoPage.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/2/27.
//

import SwiftUI

struct SheetDemoPage: View {
    
    @StateObject private var navManager = NavManager.shared
    @State var showAlert: Bool = false
    @State var showSheet: Bool = false
    @State var showPop: Bool = false


    var body: some View {
      NavigationStack(path: $navManager.path) {
          ScrollView(.vertical, showsIndicators: true) {
              
              VStack(alignment: .leading, spacing: 10, content: {
                  NSectionView(title: "Sheet", desc: "", content: {
                      
                      TextButon(title: "Alert", action: {
                          DDLog("Alert")
                          self.showAlert = true

                      }).alert(isPresented: $showAlert, content: {
                          Alert(title: Text("标题"),
                                message: Text("内容"),
                                primaryButton: .destructive(Text("确定")),
                                secondaryButton: .cancel()
                          )
                      })
                      
                      TextButon(title: "actionSheet", action: {
                          DDLog("actionSheet")
                          self.showSheet = true

                      }).actionSheet(isPresented: $showSheet, content: {
                          ActionSheet(title: Text("标题"), message: Text("内容"), buttons: [
                              .destructive(Text("destructive 按钮"), action: {
                                  print("你点击了 destructive 按钮")
                              }),
                              .destructive(Text("destructive 按钮"), action: {
                                  print("你点击了 destructive 按钮")
                              }),
                              .default(Text("default 按钮"), action: {
                                  print("你点击了 default 按钮")
                              }),
                              .cancel(Text("取消"), action: {
                                  print("你点击了 取消 按钮")
                              })
                          ])
                      })
                      
                      TextButon(title: "sheet 浮层", action: {
                          self.showPop = true
                
                      }).sheet(isPresented: $showPop, content: {
                          if #available(iOS 16.0, *) {
                              NavigationStack {
                                  PopLayerVeiew()
                              }
          //                    .presentationDetents([.medium, .large])
                              .presentationDetents([.height(600),])
                              .presentationDragIndicator(.visible)
                          } else {
                              PopLayerVeiew()
                          }
                      })
                  })
                                
              }).padding(10)
          }
          .navigationDestination(for: HashableAnyView.self) { view in
              view.view
          }
          .navigationTitle(
              "\(clsName)"
          )
          .navigationBarTitleDisplayMode(.inline)
      }
  }
}

#Preview {
    SheetDemoPage()
}


struct PopLayerVeiew: View {

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        return VStack(spacing: 15) {
            Text("自定义弹窗内容")
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("点击退出")
            })
        }
    }
}
