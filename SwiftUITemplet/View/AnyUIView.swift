//
//  AnyUIView.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2023/8/19.
//

import SwiftUI
import UIKit

struct AnyUIView<Wrapper : UIView>: UIViewRepresentable {

    var makeView: () -> Wrapper
    var update: (Wrapper, Context) -> Void

    init(_ makeView: @escaping @autoclosure () -> Wrapper,
         updater update: @escaping (Wrapper) -> Void) {
        self.makeView = makeView
        self.update = { view, _ in update(view) }
    }

    func makeUIView(context: Context) -> Wrapper {
        makeView()
    }

    func updateUIView(_ view: Wrapper, context: Context) {
        update(view, context)
    }
}

