//
//  color_ext.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/2/18.
//

import Foundation
import SwiftUI


extension Color {
    
    static let cyanNew: Self = {
        if #available(iOS 15.0, *) {
            return .cyan
        } else {
            return .black
        }
    }()
}
