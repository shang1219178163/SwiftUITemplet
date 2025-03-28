//
//  CircleLayout.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/3/14.
//

import SwiftUI

struct CircleLayout: Layout {
    var spacing: CGFloat  // ✅ 让 Layout 监听 spacing 变化
    var rotationAngle: CGFloat = 0

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        return CGSize(width: 200, height: 200)
    }


    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = min(bounds.width, bounds.height) / 2.5
        let count = subviews.count
        guard count > 0 else { return }

        let totalSpacing = CGFloat(count) * spacing
        let angleStep = (360 - totalSpacing) / CGFloat(count)

        for (index, subview) in subviews.enumerated() {
            let angle = ((angleStep + spacing) * CGFloat(index) + rotationAngle) * .pi / 180  // 旋转整体布局
            let x = center.x + radius * cos(angle)
            let y = center.y + radius * sin(angle)
            subview.place(at: CGPoint(x: x, y: y), proposal: proposal)
        }
    }
}



struct CircleView: View {
    @Binding var spacing: CGFloat

    var body: some View {
        CircleLayout(spacing: spacing) {
            ForEach(0..<8, id: \.self) { i in
                Circle()
                    .fill(Color.blue)
                    .frame(width: 40, height: 40)
                    .overlay(Text("\(i)").foregroundColor(.white))
            }
        }
        .frame(width: 250, height: 250)
    }
}
