//
//  UserDefaults_ext.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/4/1.
//

public extension UserDefaults {
    
    /// 默认 plist 路径
    var plistPath: String? {
        guard let bundleID = Bundle.main.bundleIdentifier,
              let dir = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)
                  .first else {
            return nil
        }
        let path = dir.appending("/Preferences/\(bundleID).plist")
        return path;
    }
    
    /// **存储 Codable 模型为 JSON 字符串**
    @discardableResult
    func save<T: Codable>(_ object: T, forKey key: String) -> Bool{
        let encoder = JSONEncoder()
        guard let jsonData = try? encoder.encode(object),
              let jsonString = String(data: jsonData, encoding: .utf8) else {
            return false
        }
        self.set(jsonString, forKey: key)
        return true
    }

    /// **从 JSON 字符串读取 Codable 模型**
    func load<T: Codable>(_ type: T.Type, forKey key: String) -> T? {
        guard let jsonString = self.string(forKey: key),
              let jsonData = jsonString.data(using: .utf8) else {
            return nil
        }
        let decoder = JSONDecoder()
        return try? decoder.decode(T.self, from: jsonData)
    }
    
    /// 更新模型中的某个字段
    func update<T: Codable>(_ type: T.Type, forKey key: String, updateBlock: (inout T) -> Void) {
        guard var object = load(type, forKey: key) else { return }
        updateBlock(&object)
        save(object, forKey: key)
    }
    
    /// 删除存储的模型
    func remove(forKey key: String) {
        self.removeObject(forKey: key)
    }
}
