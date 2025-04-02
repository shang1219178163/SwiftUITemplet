//
//  View.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/4/2.
//

import SwiftUICore


public extension View {
    /// 转为 AnyView
    var anyView: AnyView {
        return AnyView(self)
    }
}
