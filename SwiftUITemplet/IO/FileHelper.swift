//
//  FileHelper.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/3/28.
//

import Foundation

struct FileHelper {
    
    /// 获取 `Documents` 目录路径
    static func getDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    /// 获取指定文件的完整路径
    static func filePath(for fileName: String) -> URL {
        return getDocumentsDirectory().appendingPathComponent(fileName)
    }
    
    /// **创建文件**
    @discardableResult
    static func createFile(fileName: String, content: String = "") -> Bool {
        let fileURL = filePath(for: fileName)
        if FileManager.default.fileExists(atPath: fileURL.path) {
            print("⚠️ 文件已存在: \(fileURL.path)")
            return false
        }
        do {
            try content.write(to: fileURL, atomically: true, encoding: .utf8)
            print("✅ 文件创建成功: \(fileURL.path)")
            return true
        } catch {
            print("❌ 创建文件失败: \(error)")
            return false
        }
    }

    /// **删除文件**
    @discardableResult
    static func deleteFile(fileName: String) -> Bool {
        let fileURL = filePath(for: fileName)
        if !FileManager.default.fileExists(atPath: fileURL.path) {
            print("⚠️ 文件不存在: \(fileName)")
            return false
        }
        do {
            try FileManager.default.removeItem(at: fileURL)
            print("✅ 文件删除成功: \(fileName)")
            return true
        } catch {
            print("❌ 删除文件失败: \(error)")
            return false
        }
    }

    /// **写入 JSON 数据**
    @discardableResult
    static func writeJSON<T: Encodable>(fileName: String, data: T) -> Bool {
        let fileURL = filePath(for: fileName)
        do {
            let jsonData = try JSONEncoder().encode(data)
            try jsonData.write(to: fileURL, options: .atomic)
            print("✅ JSON 写入成功: \(fileName)")
            return true
        } catch {
            print("❌ JSON 写入失败: \(error)")
            return false
        }
    }

    /// **读取 JSON 数据**
    @discardableResult
    static func readJSON<T: Decodable>(fileName: String, type: T.Type) -> T? {
        let fileURL = filePath(for: fileName)
        guard FileManager.default.fileExists(atPath: fileURL.path) else {
            print("⚠️ 文件不存在: \(fileName)")
            return nil
        }
        do {
            let data = try Data(contentsOf: fileURL)
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            print("✅ JSON 读取成功: \(fileName)")
            return decodedData
        } catch {
            print("❌ JSON 读取失败: \(error)")
            return nil
        }
    }
    
    /// **更新 JSON 文件**
    @discardableResult
    static func updateJSON<T: Codable>(fileName: String, updateBlock: (inout T) -> Void) -> Bool {
        guard var existingData: T = readJSON(fileName: fileName, type: T.self) else {
            print("⚠️ 读取 JSON 失败，无法更新: \(fileName)")
            return false
        }
        updateBlock(&existingData)
        return writeJSON(fileName: fileName, data: existingData)
    }
}
