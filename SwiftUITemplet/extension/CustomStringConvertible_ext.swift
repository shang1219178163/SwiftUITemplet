//
//  CustomStringConvertible_ext.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/4/1.
//

public extension CustomStringConvertible {
    /// 当前类名
    var structName: String {
//        let type = "\(type(of: self))"
        return String(describing: Self.self)
    }
}
