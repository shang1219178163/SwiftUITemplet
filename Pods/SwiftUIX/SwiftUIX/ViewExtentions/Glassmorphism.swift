//
//  BlurView.swift
//  TheHatGame
//
//  Created by Daniel Pustotin on 04.09.2021.
//

import SwiftUI

fileprivate struct BlurView: UIViewRepresentable {
	private var effect: UIVisualEffect = UIBlurEffect(style: .systemThinMaterialDark)

	func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView {
		UIVisualEffectView()
	}
	func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) {
		uiView.effect = effect
	}
}

extension View {
	func glassmorphism(cornerRadius: CGFloat = cornerRadiusBig, gradient: LinearGradient = LinearGradient(gradient: Gradient(colors: [.white.opacity(0.4), .white.opacity(0.05)]), startPoint: .topLeading, endPoint: .bottomTrailing)) -> some View {

		return self
			.background(
				BlurView()
					.overlay(
						RoundedRectangle(cornerRadius: cornerRadius)
							.stroke(gradient, lineWidth: 1)
					)
					.background(gradient)

			)
			.clipShape(RoundedRectangle(cornerRadius: cornerRadius))
			.shadow(color: Color.black.opacity(0.3), radius: cornerRadius, x: cornerRadius, y: cornerRadius)
	}
}
