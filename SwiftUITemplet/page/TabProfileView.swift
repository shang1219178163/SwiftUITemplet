//
//  TabProfileView.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/3/4.
//

import SwiftUI

struct TabProfileView: View {
    @StateObject private var router = Router.shared

    var body: some View {
        List {
            Section {
                HStack {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.gray)
                    
                    VStack(alignment: .leading) {
                        Text("用户名")
                            .font(.headline)
                        Text("查看或编辑个人资料")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    router.toNamed(AppRouter.editProfile)
                }
            }
            
            Section("功能") {
                Button {
                    router.toNamed(AppRouter.collection)
                } label: {
                    Label("我的收藏", systemImage: "star.fill")
                }
                
                Button {
                    router.toNamed(AppRouter.notification)
                } label: {
                    Label("消息通知", systemImage: "bell.fill")
                }
            }
            
            Section {
                Button {
                    router.toNamed(AppRouter.settings, arguments: ["a": "aa",
                                                                   "onNext": onNext,
                                                                   "onResult": onResult,
                                                                  ])
                } label: {
                    Label("设置", systemImage: "gear")
                }
            }
        }
    }
    
    func onNext(result: String) -> Void {
       DDLog("\(result)")
    }
   
    func onResult(result: [String: Any]) -> Void {
       DDLog("\(result)")
    }
}

#Preview {
    TabProfileView()
}
