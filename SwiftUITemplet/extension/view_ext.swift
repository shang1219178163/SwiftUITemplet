//
//  view_ext.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/2/18.
//

import Foundation
import SwiftUI


extension View {
    
    var clsName: String {
        var clsName = String(describing: Self.self)
        return clsName;
    }

    /// API 兼容
    func scrollDisabledNew() -> some View {
        if #available(iOS 16.0, *) {
            return self.scrollDisabled(true)
        } else {
            return self
        }
    }

    /// API 兼容
    func tintNew(_ color: Color?) -> some View {
       if #available(iOS 16.0, *) {
           return self.tint(color)
       } else {
           return self.accentColor(color)
       }
   }
}
