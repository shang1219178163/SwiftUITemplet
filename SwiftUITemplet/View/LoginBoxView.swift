//
//  LoginBoxView.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/2/19.
//

import SwiftUI

/// 登录盒子
struct LoginBoxView: View {
    @Binding var username: String
    @Binding var password: String
    
    var body: some View {
        VStack(alignment: .leading, content: {
            TextField("请输入账号", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Text("\($username.wrappedValue.isEmpty ? "只允许数字和英文" : $username.wrappedValue)")
                .foregroundColor(.red)

            // SecureField
            SecureField("请输入密码", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Text("\($password.wrappedValue.isEmpty ? "最少6位" : $password.wrappedValue)")
                .foregroundColor(.red)
        })
        .padding()
        .overlay(                  // 通过 overlay 给视图添加边框
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray, lineWidth: 0.5) // 边框颜色和宽度
        )
    }
}

//#Preview {
//    @State var username: String = ""
//    @State var password: String = ""
//    
//    LoginBoxView(username: $username, password: $password)
//}
