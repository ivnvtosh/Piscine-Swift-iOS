//
//  main.swift
//  CardGame
//
//  Created by Anton Ivanov on 12.08.2022.
//

func printHeader(message: String) {
	print("------------------------")
	print(message)
	print("------------------------")
}

func testCardinitializer() {
	printHeader(message: "Test card initializer")

	let cardSpadesAce = Card(color: .spades, value: .ace)
	let cardDiamondstwo = Card(color: .diamonds, value: .two)
	let cardHeartsThree = Card(color: .hearts, value: .three)
	let cardClubsFour = Card(color: .clubs, value: .four)

	print(cardSpadesAce.color, cardSpadesAce.value)
	print(cardDiamondstwo.color, cardDiamondstwo.value)
	print(cardHeartsThree.color, cardHeartsThree.value)
	print(cardClubsFour.color, cardClubsFour.value)
}

func testCardDescription() {
	printHeader(message: "Test card description")

	let cardSpadesAce = Card(color: .spades, value: .ace)
	let cardDiamondstwo = Card(color: .diamonds, value: .two)
	let cardHeartsThree = Card(color: .hearts, value: .three)
	let cardClubsFour = Card(color: .clubs, value: .four)

	print(cardSpadesAce)
	print(cardDiamondstwo)
	print(cardHeartsThree)
	print(cardClubsFour)
}

func testCardEqual() {
	printHeader(message: "Test card equal")

	let cardSpadesNine = Card(color: .spades, value: .nine)
	let cardDiamondsFive = Card(color: .diamonds, value: .five)

	let cardSpadesAce = Card(color: .spades, value: .ace)
	let cardSpadesTwo = Card(color: .spades, value: .two)

	let cardDiamondstwo = Card(color: .diamonds, value: .two)
	let cardHeartsTwo = Card(color: .hearts, value: .two)

	let cardClubsFour1 = Card(color: .clubs, value: .four)
	let cardClubsFour2 = Card(color: .clubs, value: .four)

	print(cardSpadesNine == cardDiamondsFive)
	print(cardSpadesAce == cardSpadesTwo)
	print(cardDiamondstwo == cardHeartsTwo)
	print(cardClubsFour1 == cardClubsFour2)
}

testCardinitializer()
testCardDescription()
testCardEqual()

