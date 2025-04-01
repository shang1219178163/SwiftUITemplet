//
//  Dictionary_ext.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/4/1.
//



public extension Dictionary where Key == AnyHashable, Value == Any {
    /// 转文字
    var jsonString: String? {
        guard let jsonData = try? JSONSerialization.data(withJSONObject: self, options: .sortedKeys),
                let jsonString = String(data: jsonData, encoding: .utf8) else {
              return nil
          }
        return jsonString
    }
    
    /// 根据值进行判断
    static func == (lhs: [AnyHashable: Any], rhs: [AnyHashable: Any]?) -> Bool {
        // 首先比较键的数量
        guard lhs.count == rhs?.count else {
            return false
        }
        let result = lhs.jsonString == rhs?.jsonString;
//        let result = NSDictionary(dictionary: lhs).isEqual(to: rhs ?? [:]);
        return result
    }
    
//    /// 根据值进行判断
//    static func == (lhs: [AnyHashable: Any], rhs: [AnyHashable: Any]?) -> Bool {
//        // 辅助函数：递归比较任意两个值
//        func isEqual(_ lhs: Any, _ rhs: Any) -> Bool {
//            // 处理nil值的情况（NSNull）
//    //        if let lhs = lhs as? NSNull, let _ = rhs as? NSNull {
//    //            return true
//    //        }
//            
//            // 处理基本类型
//            switch (lhs, rhs) {
//            case (let lhs as String, let rhs as String): return lhs == rhs
//            case (let lhs as Int, let rhs as Int): return lhs == rhs
//            case (let lhs as Double, let rhs as Double): return lhs == rhs
//            case (let lhs as Float, let rhs as Float): return lhs == rhs
//            case (let lhs as Bool, let rhs as Bool): return lhs == rhs
//            case (let lhs as [AnyHashable: Any], let rhs as [AnyHashable: Any]): return lhs == rhs
//            case (let lhs as [Any], let rhs as [Any]): return isEqualArray(lhs, rhs)
//            default:
//                return false
//            }
//        }
//        
//        // 辅助函数：比较数组
//        func isEqualArray(_ lhs: [Any], _ rhs: [Any]) -> Bool {
//            guard lhs.count == rhs.count else {
//                return false
//            }
//            
//            for (lhsElement, rhsElement) in zip(lhs, rhs) {
//                if !isEqual(lhsElement, rhsElement) {
//                    return false
//                }
//            }
//            
//            return true
//        }
//        
//        // 首先比较键的数量
//        guard let rhs = rhs, lhs.count == rhs.count else {
//            return false
//        }
//        
//        // 遍历所有键值对进行比较
//        for (key, lhsValue) in lhs {
//            guard let rhsValue = rhs[key] else {
//                return false
//            }
//            
//            // 递归比较值
//            if !isEqual(lhsValue, rhsValue) {
//                return false
//            }
//        }
//        
//        return true
//    }
    

    

}
