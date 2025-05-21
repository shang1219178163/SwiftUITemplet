//
//  MainActor_ext.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/4/28.
//


extension MainActor {
    /// 安全方法
    static func runSafely<T: Sendable>(_ block: @MainActor () -> T) throws -> T {
        if Thread.isMainThread {
          return MainActor.assumeIsolated { block() }
        }
    
        MainActor.assertIsolated("This method is expected to be called in main thread!")
        return DispatchQueue.main.sync {
            MainActor.assumeIsolated { block() }
        }
  }
}
