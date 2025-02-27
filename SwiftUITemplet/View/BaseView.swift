//
//  BaseView.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/2/20.
//

import SwiftUI

struct BaseView: View {
    @StateObject private var pathModel = NavManager.shared

    
    var body: some View {
        NavigationStack(path: $pathModel.path) {
            ScrollView(.vertical, showsIndicators: true) {
                
                VStack(alignment: .leading, spacing: 10, content: {
                    
                    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
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
    BaseView()
}



struct RouterModel: Hashable {

    let name: String
    let view: any View

    // 为了使其遵循 Hashable 协议，我们需要实现 hash(into:)
    func hash(into hasher: inout Hasher) {
        // 使用 AnyView 的类型信息来生成哈希值
        hasher.combine(String(describing: type(of: view)))
    }

    // 实现符合 Hashable 协议的 == 操作符
    static func == (lhs: RouterModel, rhs: RouterModel) -> Bool {
        return String(describing: type(of: lhs.view)) == String(describing: type(of: rhs.view))
    }
}
