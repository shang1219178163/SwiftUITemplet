//
//  SettingsView.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/3/3.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        Text("Hello, World! SettingsView")
        
        Button {
            DDLog("button")
            
        } label: {
            return Text("Button")
        }
    }
}

#Preview {
    SettingsView()
}
