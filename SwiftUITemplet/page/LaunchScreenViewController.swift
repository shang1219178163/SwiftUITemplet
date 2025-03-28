//
//  LaunchScreenViewController.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/3/28.
//

import UIKit
import SwiftUI

class LaunchScreenViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let swiftUIView = LaunchScreenSwiftUIView()
        let hostingController = UIHostingController(rootView: swiftUIView)
        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.view.frame = view.bounds
        hostingController.didMove(toParent: self)
    }
}



struct LaunchScreenSwiftUIView: View {
    var body: some View {
        ZStack {
            Color(.systemBackground) // 适配暗黑模式
            Image("IMG_3494")
                .resizable()
                .scaledToFill()
              
        }
        .ignoresSafeArea()
    }
}

#Preview {
    LaunchScreenSwiftUIView()
}
