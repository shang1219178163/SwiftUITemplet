//
//  log.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/2/18.
//

import Foundation


func DDLog(_ message: Any, file: String = #file, function: String = #function, line: Int = #line) {
    // 获取当前时间
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
    let timestamp = dateFormatter.string(from: Date())
    
    // 提取文件名（去掉路径）
    let fileName = (file as NSString).lastPathComponent
    
    // 打印日志信息
    print("\(timestamp) [\(fileName):\(line)] \(function): \(message)")
}
