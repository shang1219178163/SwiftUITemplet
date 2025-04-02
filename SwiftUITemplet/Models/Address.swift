//
//  Address.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/4/1.
//


struct Address: Codable, BaseTypeCodable {
    var city: String?
    var zipCode: String?
    
    enum CodingKeys: String, CodingKey {
        case city
        case zipCode
    }
    
    init(city: String? = "", zipCode: String? = "") {
        self.city = city
        self.zipCode = zipCode
    }
    
    static var defaultValue: Self {
        Self.init(city: String.defaultValue, zipCode: String.defaultValue)
    }

    // 自定义 JSON 解析
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.city = try container.decodeIfPresent(String.self, forKey: .city) ?? ""
        self.zipCode = try container.decodeIfPresent(String.self, forKey: .zipCode) ?? ""
    }

    // 自定义 JSON 编码（可选）
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(city, forKey: .city)
        try container.encode(zipCode, forKey: .zipCode)
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
