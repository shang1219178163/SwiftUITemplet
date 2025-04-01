//
//  UserModel.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/3/28.
//

import Foundation

/// 自定义用户模型
struct UserModel: Codable, CustomStringConvertible {
    var name: String
    var age: Int
    /// 座右铭
    var motto: String?
    var hobbies: [String]?

    
    enum CodingKeys: String, CodingKey {
        case name
        case age
        case motto
        case hobbies
    }
    
    init(name: String, age: Int = 18, motto: String? = "", hobbies: [String]? = []) {
        self.name = name
        self.age = age
        self.motto = motto
        self.hobbies = hobbies
    }
    
    

    // 自定义 JSON 解析
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.age = try container.decode(Int.self, forKey: .age)
        /// 可空
        self.motto = try container.decodeIfPresent(String.self, forKey: .motto) ?? ""
        self.hobbies = try container.decodeIfPresent([String].self, forKey: .hobbies) ?? []
    }

    // 自定义 JSON 编码（可选）
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(age, forKey: .age)
        try container.encode(motto, forKey: .motto)
        try container.encode(hobbies, forKey: .hobbies)
    }
    
    var description: String {
        let def = "UserModel 实例对象"
        guard let dict = self.toDictionary() else {
            return def
        }
        return dict.jsonString ?? def;
      }
}

