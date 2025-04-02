//
//  TagDetail.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/4/1.
//

struct TagDetail: Codable, BaseTypeCodable {
    var name: String?
    var tagId: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case tagId
    }
    
    init(name: String? = "", tagId: String? = "") {
        self.name = name
        self.tagId = tagId
    }
    
    static var defaultValue: Self {
        Self.init(name: String.defaultValue, tagId: String.defaultValue)
    }
    

    // 自定义 JSON 解析
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        self.tagId = try container.decodeIfPresent(String.self, forKey: .tagId) ?? ""
    }

    // 自定义 JSON 编码（可选）
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(tagId, forKey: .tagId)
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
