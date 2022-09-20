//
//  Deck.swift
//  CardGame
//
//  Created by Anton Ivanov on 11.08.2022.
//

import Foundation

class Deck: NSObject {

	static let allSpades: Cards = [Card(color: .spades, value: .ace),
								   Card(color: .spades, value: .two),
								   Card(color: .spades, value: .three),
								   Card(color: .spades, value: .four),
								   Card(color: .spades, value: .five),
								   Card(color: .spades, value: .six),
								   Card(color: .spades, value: .seven),
								   Card(color: .spades, value: .eight),
								   Card(color: .spades, value: .nine),
								   Card(color: .spades, value: .ten),
								   Card(color: .spades, value: .jack),
								   Card(color: .spades, value: .queen),
								   Card(color: .spades, value: .king)]

	static let allDiamonds: Cards = [Card(color: .diamonds, value: .ace),
									 Card(color: .diamonds, value: .two),
									 Card(color: .diamonds, value: .three),
									 Card(color: .diamonds, value: .four),
									 Card(color: .diamonds, value: .five),
									 Card(color: .diamonds, value: .six),
									 Card(color: .diamonds, value: .seven),
									 Card(color: .diamonds, value: .eight),
									 Card(color: .diamonds, value: .nine),
									 Card(color: .diamonds, value: .ten),
									 Card(color: .diamonds, value: .jack),
									 Card(color: .diamonds, value: .queen),
									 Card(color: .diamonds, value: .king)]

	static let allHearts: Cards = [Card(color: .hearts, value: .ace),
								   Card(color: .hearts, value: .two),
								   Card(color: .hearts, value: .three),
								   Card(color: .hearts, value: .four),
								   Card(color: .hearts, value: .five),
								   Card(color: .hearts, value: .six),
								   Card(color: .hearts, value: .seven),
								   Card(color: .hearts, value: .eight),
								   Card(color: .hearts, value: .nine),
								   Card(color: .hearts, value: .ten),
								   Card(color: .hearts, value: .jack),
								   Card(color: .hearts, value: .queen),
								   Card(color: .hearts, value: .king)]

	static let allClubs: Cards = [Card(color: .clubs, value: .ace),
								  Card(color: .clubs, value: .two),
								  Card(color: .clubs, value: .three),
								  Card(color: .clubs, value: .four),
								  Card(color: .clubs, value: .five),
								  Card(color: .clubs, value: .six),
								  Card(color: .clubs, value: .seven),
								  Card(color: .clubs, value: .eight),
								  Card(color: .clubs, value: .nine),
								  Card(color: .clubs, value: .ten),
								  Card(color: .clubs, value: .jack),
								  Card(color: .clubs, value: .queen),
								  Card(color: .clubs, value: .king)]

	static let allCards = allSpades + allDiamonds + allHearts + allClubs

}

extension Array {

	mutating func mixed() {
		let count = UInt32(self.count)

		for _ in 0...10_000 {
			let a = Int(arc4random_uniform(count))
			let b = Int(arc4random_uniform(count))

			let element = self[a]
			self[a] = self[b]
			self[b] = element
		}
	}

}

