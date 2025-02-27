//
//  double_ext.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/2/19.
//

import Foundation
import SwiftUI


extension Double {

    /// 转字符串
    func toString(_ fixed: Int = 2) -> String {
        let result = String(format: "%.\(fixed)f", self);
        return result;
    }
 
}

extension CGFloat {

    /// 转字符串
    func toString(_ fixed: Int = 2) -> String {
        return Double(self).toString(fixed);
    }
 
}


extension CGRect {

    /// 转字符串
    func toString(_ fixed: Int = 2) -> String {
        return "(\(self.minX.toString(fixed)), \(self.minY.toString(fixed)), \((self.maxX - self.minX).toString(fixed)), \((self.maxY - self.minY).toString(fixed)))";
    }
 
}

extension CGPoint {

    /// 转字符串
    func toString(_ fixed: Int = 2) -> String {
        return "(\(self.x.toString(fixed)), \(self.y.toString(fixed)))";
    }
 
}

extension EdgeInsets {

    static func symmetric(horizontal: Double = 0.0, vertical: Double = 0.0) -> EdgeInsets {
        return EdgeInsets(top: vertical,
                          leading: horizontal,
                          bottom: vertical,
                          trailing: horizontal)
    }
}


