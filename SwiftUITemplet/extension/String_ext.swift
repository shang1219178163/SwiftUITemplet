//
//  String_ext.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/2/20.
//

public extension String {

    static func * (lhs: String, rhs: Int) -> String {
        guard rhs > 0 else { return "" }
        return String(repeating: lhs, count: rhs)
    }
      
    static func *= (lhs: inout String, rhs: Int) -> String {
        guard rhs > 0 else { return "" }
        return String(repeating: lhs, count: rhs)
    }
}
