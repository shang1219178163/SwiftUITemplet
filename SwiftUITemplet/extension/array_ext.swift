//
//  list_ext.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/2/19.
//

import Foundation
import SwiftUI


extension Array {

    /// 快速生成一个数组(step代表步长)
    init(count: Int, generator: @escaping ((Int) -> Element)) {
        self = (0..<count).map(generator)
    }
    
    /// 子数组
    func range(start: Int = 0, end: Int) -> Array {
        return Array(self[start...end])
    }
 
}

