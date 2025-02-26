//
//  UIApplication_ext.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/2/25.
//

import Foundation

public extension UIApplication {
    /// 当前界面 UIWindow
    var currentWindow: UIWindow? {
        if #available(iOS 15, *) {
            if let keyWindow = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .compactMap({$0 as? UIWindowScene})
                .first?.windows
                .filter({$0.isKeyWindow}).first {
                return keyWindow;
            }
        }
        
        return UIApplication.shared.windows.first { $0.isKeyWindow };
    }
    
    /// 主题更改
    @available(iOS 13.0, *)
    func changeTheme(overrideUserInterfaceStyle: UIUserInterfaceStyle){
        currentWindow?.overrideUserInterfaceStyle = overrideUserInterfaceStyle
    }

}
