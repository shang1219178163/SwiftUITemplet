//
//  list_ext.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/2/19.
//

import Foundation
import SwiftUI


public extension Array {

    /// 快速生成一个数组(step代表步长)
    init(count: Int, generator: @escaping ((Int) -> Element)) {
        self = (0..<count).map(generator)
    }
    
    /// 子数组
    func range(start: Int = 0, end: Int) -> Array {
        return Array(self[start...end])
    }
 
    /// 将数组转换为字典，索引为键，元素为值
    func asMap<Key: Hashable>(_ keyBlock: ((Int, Element) -> Key)? = nil) -> [Key: Element] where Key == String {
        return Dictionary(uniqueKeysWithValues: enumerated().map { (keyBlock?($0.offset, $0.element) ?? "\($0.offset)", $0.element) })
    }
}

