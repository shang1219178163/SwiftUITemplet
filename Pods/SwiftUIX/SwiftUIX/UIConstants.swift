//
//  UIConstants.swift
//  SwiftUIX
//
//  Created by Daniel Pustotin on 23.09.2021.
//

import SwiftUI

// MARK: - Screen sizes
public let screen: CGSize = UIScreen.main.bounds.size
public let screenReversed = CGSize(width: -screen.width, height: -screen.height)
public let screenHalf: CGSize = CGSize(width: screen.width / 2, height: screen.height / 2)
public let screenHalfReversed: CGSize = CGSize(width: -screen.width / 2, height: -screen.height / 2)

public func screen(ratio: CGFloat) -> CGSize {
	CGSize(width: screen.width * ratio, height: screen.height * ratio)
}

// MARK: - Corners
public let cornerRadiusBig: CGFloat = 25.0
public let cornerRadiusMedium: CGFloat = 15.0
public let cornerRadiusSmall: CGFloat = 10.0
public let shadowRadiusBig: CGFloat = 20.0
public let shadowRadiusMedium: CGFloat = 10.0
public let shadowRadiusSmall: CGFloat = 5.0

// MARK: - Spacing
public let spacingBig: CGFloat = screen.width / 5
public let spacingMedium: CGFloat = screen.width / 10
public let spacingSmall: CGFloat = screen.width / 15
