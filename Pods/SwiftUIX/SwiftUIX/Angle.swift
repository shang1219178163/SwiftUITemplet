//
//  Angle.swift
//  SwiftUIX
//
//  Created by Daniel Pustotin on 25.09.2021.
//

import SwiftUI

public extension Angle {
		/// Initializer for new Angle
		/// - Parameters:
		///   - derees: Value of angle
		///   - CW: Clockwise or Counterclockwise rotation of angle
	init(_ derees: Double, CW: Bool = true) {
		self.init(degrees: derees * (CW ? 1 : -1))
	}

		/// Changes clockwise rotation of angle
	mutating func changeCW() {
		self.radians *= -1
	}

		/// Right angle has value of 90 degrees or π / 2 radians
	static let rightCW = Angle(degrees: 90)
		/// Right angle has value of 90 degrees or π / 2 radians
	static let rightCCW = Angle(degrees: -90)


		/// Small angle has value of 2 degrees
	static let smallCW = Angle(degrees: 2)
		/// Small angle has value of 2 degrees
	static let smallCCW = Angle(degrees: -2)
		/// Medium angle has value of 10 degrees
	static let mediumCW = Angle(degrees: 10)
		/// Medium angle has value of 10 degrees
	static let mediumCCW = Angle(degrees: -10)
		/// Big angle has value of 45 degrees
	static let bigCW = Angle(degrees: 45)
		/// Big angle has value of 45 degrees
	static let bigCCW = Angle(degrees: -45)
}
