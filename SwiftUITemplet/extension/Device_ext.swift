//
//  Device_ext.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/2/25.
//

import Foundation


public extension UIDevice {
    /// 唯一识别号
    var uuid: String? {
        var result = UIDevice.current.identifierForVendor?.uuidString
        return result;
    }

}
