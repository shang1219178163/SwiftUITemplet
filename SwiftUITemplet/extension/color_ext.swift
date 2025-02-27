//
//  color_ext.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/2/18.
//

import Foundation
import SwiftUI


extension Color {
    
    static var random: Color {
        return Color(
            red: Double.random(in: 0...1),
            green: Double.random(in: 0...1),
            blue: Double.random(in: 0...1)
        )
    }
    
    static let cyanNew: Self = {
        if #available(iOS 15.0, *) {
            return .cyan
        } else {
            return .black
        }
    }()
    

}
