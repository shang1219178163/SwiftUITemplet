//
//  DispatchQueue_ext.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/5/7.
//

extension DispatchQueue {
    static func mainAsyncRun(_ work: @Sendable @escaping () -> Void){
        if Thread.current.isMainThread {
            work()
            return;
        }
        main.async {
            work()
        }
    }
}
