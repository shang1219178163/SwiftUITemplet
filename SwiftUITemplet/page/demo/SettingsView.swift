//
//  SettingsView.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/3/3.
//

import SwiftUI

struct SettingsView: View {
    @StateObject private var router = Router.shared
    
    /// 方法做参
    var onNext: ((String) -> Void)? {
        guard let result = router.currentArgs?["onNext"] as? ((String) -> Void)? else { return nil }
        return result
    }
    
    var onResult: (([String: Any]) -> Void)? {
        guard let result = router.currentArgs?["onResult"] as? (([String: Any]) -> Void)? else { return nil }
        return result
    }
    
    
    var body: some View {
        VStack(spacing: 10, content: {
            Text("Hello, World! SettingsView")
            
            Button {
                DDLog("currentArgs \(router.currentArgs ?? [:])")
                onResult?(router.currentArgs ?? [:])
            } label: {
                Text("currentArgs")
            }
            
            Button {
                DDLog("onNext \(router.currentArgs ?? [:])")
                onNext?(clsName)
            } label: {
                Text("onNext")
            }
        })
    }
}

#Preview {
    SettingsView()
}
