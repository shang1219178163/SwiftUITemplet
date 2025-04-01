//
//  encodable_ext.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/3/31.
//


public extension Encodable {
    /// **模型转字典**
    func toDictionary() -> [AnyHashable: Any]? {
        guard let data = try? JSONEncoder().encode(self) else {
            return nil
        }
        let result = (try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)) as? [AnyHashable: Any]
        return result;
    }
    
}


public extension Decodable {
    /// **字典转模型**
    static func fromDictionary(_ dict: [AnyHashable: Any]) -> Self? {
        guard let data = try? JSONSerialization.data(withJSONObject: dict, options: .fragmentsAllowed) else {
            return nil
        }
        let result = try? JSONDecoder().decode(Self.self, from: data)
        return result;
    }
}
