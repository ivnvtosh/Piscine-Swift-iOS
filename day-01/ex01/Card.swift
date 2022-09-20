//
//  Card.swift
//  CardGame
//
//  Created by Anton Ivanov on 11.08.2022.
//

import Foundation

// MARK: - Card
class Card: NSObject {

	let color: Color
	let value: Value

	init(color: Color, value: Value) {
		self.color = color
		self.value = value
	}

	override var description: String {
		return "(\(value.rawValue), \(color))"
	}

	override func isEqual(_ object: Any?) -> Bool {
		guard let card = object as? Card else {
			return false
		}

		return self.color == card.color && self.value == card.value
	}

//	static func == (lhs: Card, rhs: Card) -> Bool {
//		return lhs.isEqual(rhs)
//		return lhs.color == rhs.color && lhs.value == rhs.value
//	}

}

typealias Cards = [Card]

