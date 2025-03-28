//
//  TextFieldDemoPage.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/2/27.
//

import SwiftUI

struct TextFieldDemoPage: View {
    @StateObject private var router = Router.shared

    @State var account: String = ""
    @State var password: String = ""
    @State var number: String = ""
    @State var emailAddress: String = ""
    
    var body: some View {
        NavigationStack(path: $router.path) {
            Form {
                Section(header: Text("结果展示区")) {
                    Text("账号: \(self.account)")
                        .foregroundColor(.gray)
                        .font(.system(size: 14))
                    Text("密码: \(self.password)")
                        .foregroundColor(.gray)
                        .font(.system(size: 14))
                    Text("数字: \(self.number)")
                        .foregroundColor(.gray)
                        .font(.system(size: 14))
                    Text("邮件: \(self.emailAddress)")
                        .foregroundColor(.gray)
                        .font(.system(size: 14))
                }
                
                Section(header: Text("账号和密码输入")) {
                    if #available(iOS 15.0, *) {
                        TextField(text: $account, label: {
                            Text("请输入账号")
                        })
                    } else {
                        TextField("请输入账号", text: $account)
                    }
                    if #available(iOS 15.0, *) {
                        SecureField(text: $password, prompt: Text("请输入密码"), label: {
                            Text("输入密码 Label")
                        })
                    } else {
                        SecureField("输入密码", text: $password)
                    }
                }
                Section(header: Text("数字输入框")) {
                    if #available(iOS 15.0, *) {
                        TextField("请输入数字", text: $number)
                            .keyboardType(.numberPad)
                    } else {
                        TextField("请输入数字", text: $number)
                            .keyboardType(.numberPad)
                    }
                }
                Section(header: Text("邮箱输入框")) {
                    if #available(iOS 15.0, *) {
                        TextField(text: $emailAddress, label: {
                            Text("请输入邮箱")
                        })
                    } else {
                        TextField("请输入邮箱", text: $emailAddress)
                            .keyboardType(.emailAddress)
                    }
                }
            }
            .navigationBar(title: "\(clsName)")
  //            .navigationDestination(for: AppPage<AnyView>.self) { page in
  //                page.makeView()
  //            }
        }
    }
}

#Preview {
    TextFieldDemoPage()
}
