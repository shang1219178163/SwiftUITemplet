//
//  BaseView.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/2/20.
//

import SwiftUI

struct BaseView: View {
    @StateObject private var router = Router.shared

    
    var body: some View {
        NavigationStack(path: $router.path) {
            ScrollView(.vertical, showsIndicators: true) {
                
                VStack(alignment: .leading, spacing: 10, content: {
                    
                    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
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
    BaseView()
}



struct BaseRouterModel: Hashable {

    let name: String
    let view: any View

    // 为了使其遵循 Hashable 协议，我们需要实现 hash(into:)
    func hash(into hasher: inout Hasher) {
        // 使用 AnyView 的类型信息来生成哈希值
        hasher.combine(String(describing: type(of: view)))
    }

    // 实现符合 Hashable 协议的 == 操作符
    static func == (lhs: BaseRouterModel, rhs: BaseRouterModel) -> Bool {
        return String(describing: type(of: lhs.view)) == String(describing: type(of: rhs.view))
    }
}
