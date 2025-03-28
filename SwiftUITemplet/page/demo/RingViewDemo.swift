//
//  RingViewDemo.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/3/14.
//

import SwiftUI

struct RingViewDemo: View {
    @State private var progress: CGFloat = 0.75
    @State private var thickness: CGFloat = 20
    @State private var spacing: CGFloat = 10
    @State private var rotationAngle: Angle = .degrees(0)

    var body: some View {
        VStack {
            RingView(progress: progress, thickness: thickness, spacing: spacing, rotationAngle: rotationAngle)
                .frame(width: 200, height: 200)

            SliderWithLabel(value: $progress, label: "Progress", range: 0...1)
            Slider(value: $thickness, in: 10...50, step: 1) {
                Text("Thickness")
            }
            Slider(value: $spacing, in: 0...50, step: 1) {
                Text("Spacing")
            }
            Slider(value: .init(get: {
                rotationAngle.degrees
            }, set: { newValue in
                rotationAngle = .degrees(newValue)
            }), in: 0...360, step: 1) {
                Text("Rotation")
            }
        }
        .padding()
    }
}

#Preview {
    RingViewDemo()
}


struct RingView: View {
    var progress: CGFloat // 进度，范围是 0 到 1
    var thickness: CGFloat // 环的厚度
    var spacing: CGFloat // 环的间距
    var rotationAngle: Angle // 旋转角度

    var body: some View {
        ZStack {
            // 背景环
            Circle()
                .stroke(Color.gray.opacity(0.3), lineWidth: thickness)
                .padding(spacing)

            // 前景环
            Circle()
                .trim(from: 0, to: progress)
                .stroke(Color.blue, style: StrokeStyle(lineWidth: thickness, lineCap: .round))
                .padding(spacing)
                .rotationEffect(rotationAngle)
        }
    }
}


struct SliderWithLabel: View {
    @Binding var value: CGFloat
    var label: String
    var range: ClosedRange<CGFloat>

    var body: some View {
        HStack {
            Text(label)
            Slider(value: $value, in: range)
        }
    }
}

