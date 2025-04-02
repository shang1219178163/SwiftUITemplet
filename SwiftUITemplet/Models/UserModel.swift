//
//  UserModel.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/3/28.
//

import Foundation


/// 自定义用户模型
struct UserModel: Codable, CustomStringConvertible, BaseTypeCodable {
    var name: String
    var age: Int
    /// 座右铭
    var motto: String?
    var hobbies: [String]?
    var address: Address?
    var tags: [TagDetail]?

    
    enum CodingKeys: String, CodingKey {
        case name
        case age
        case motto
        case hobbies
        case address
        case tags
    }
    
    init(name: String,
         age: Int = 18,
         motto: String? = "",
         hobbies: [String]? = [],
         address: Address? = nil,
         tags: [TagDetail]? = []) {
        self.name = name
        self.age = age
        self.motto = motto
        self.hobbies = hobbies
        self.address = address
        self.tags = tags
    }
    
    public static var defaultValue: Self {
        Self.init(name: String.defaultValue,
                  age: Int.defaultValue,
                  motto: String?.defaultValue,
                  hobbies: Array<String>.defaultValue,
                  address: Address.defaultValue,
                  tags: Array<TagDetail>.defaultValue
        )
    }

    // 自定义 JSON 解析
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.age = try container.decode(Int.self, forKey: .age)
        /// 可空
        self.motto = try container.decodeIfPresent(String.self, forKey: .motto) ?? ""
        self.hobbies = try container.decodeIfPresent([String].self, forKey: .hobbies) ?? []
        self.address = try container.decodeIfPresent(Address.self, forKey: .address)
        self.tags = try container.decodeIfPresent([TagDetail].self, forKey: .tags) ?? []
    }

    // 自定义 JSON 编码（可选）
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(age, forKey: .age)
        try container.encode(motto, forKey: .motto)
        try container.encode(hobbies, forKey: .hobbies)
        try container.encode(address, forKey: .address)
        try container.encode(tags, forKey: .tags)
    }
    
    var description: String {
        let type = "\(type(of: self))"
//        let type =  String(describing: Self.self)
        
        guard let result = toDict()?.jsonString else {
            return "\(type) 实例对象"
        }
        return "\(type) \(result)";
      }
}

