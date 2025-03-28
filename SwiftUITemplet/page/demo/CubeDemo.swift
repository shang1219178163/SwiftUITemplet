//
//  cubeDemo.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/3/14.
//

import SwiftUI

struct CubeDemo: View {
    @State private var rotation: Angle = .zero // 控制立方体的旋转角度

    var body: some View {
        VStack {
            // 立方体视图
            CubeView(rotation: $rotation)
                .frame(width: 200, height: 200)
                .padding()

            // 旋转控制滑块
            Slider(value: .init(get: {
                rotation.degrees
            }, set: { newValue in
                rotation = .degrees(newValue)
            }), in: 0...360, step: 1) {
                Text("Rotation")
            }
            .padding()
        }
    }
}

#Preview {
    CubeDemo()
}




struct CubeView: View {
    @Binding var rotation: Angle

    var body: some View {
        ZStack {
            // 前面
            FaceView(text: "Front")
                .rotation3DEffect(.degrees(0), axis: (x: 0, y: 1, z: 0))
                .transformEffect(.init(translationX: 0, y: 0)) // 前面不需要 z 偏移

            // 后面
            FaceView(text: "Back")
                .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                .transformEffect(.init(translationX: 0, y: 0)) // 后面不需要 z 偏移

            // 左面
            FaceView(text: "Left")
                .rotation3DEffect(.degrees(-90), axis: (x: 0, y: 1, z: 0))
                .transformEffect(.init(translationX: -50, y: 0)) // 左面 x 偏移

            // 右面
            FaceView(text: "Right")
                .rotation3DEffect(.degrees(90), axis: (x: 0, y: 1, z: 0))
                .transformEffect(.init(translationX: 50, y: 0)) // 右面 x 偏移

            // 上面
            FaceView(text: "Top")
                .rotation3DEffect(.degrees(-90), axis: (x: 1, y: 0, z: 0))
                .transformEffect(.init(translationX: 0, y: -50)) // 上面 y 偏移

            // 下面
            FaceView(text: "Bottom")
                .rotation3DEffect(.degrees(90), axis: (x: 1, y: 0, z: 0))
                .transformEffect(.init(translationX: 0, y: 50)) // 下面 y 偏移
        }
        .rotation3DEffect(rotation, axis: (x: 1, y: 1, z: 0)) // 整体旋转
    }
}

struct FaceView: View {
    let text: String

    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.blue.opacity(0.5))
                .border(Color.black, width: 2)

            // 每个面显示 9 个标签
            VStack(spacing: 10) {
                ForEach(0..<3, id: \.self) { row in
                    HStack(spacing: 10) {
                        ForEach(0..<3, id: \.self) { col in
                            Text("\(text)\n\(row * 3 + col + 1)")
                                .font(.system(size: 12))
                                .multilineTextAlignment(.center)
                                .frame(width: 40, height: 40)
                                .background(Color.white.opacity(0.8))
                                .cornerRadius(5)
                        }
                    }
                }
            }
        }
        .frame(width: 100, height: 100)
    }
}
