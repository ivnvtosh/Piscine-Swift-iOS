//
//  main.swift
//  CardGame
//
//  Created by Anton Ivanov on 12.08.2022.
//

import Foundation

func printHeader(message: String) {
	print("---------------------------------")
	print(message)
	print("---------------------------------")
}

func testDeckCardsInitializerFalse() {
	printHeader(message: "Test deck cards initializer false")

	let deck = Deck(isMixed: false)

	for card in deck.cards {
		print(card)
	}
}

func testDeckCardsInitializerTrue() {
	printHeader(message: "Test deck cards initializer true")

	let deck = Deck(isMixed: true)

	for card in deck.cards {
		print(card)
	}
}

func testDeckDescription() {
	printHeader(message: "Test deck description")

	let deck = Deck(isMixed: true)

	print(deck)
}

func testDeckDrawOne() {
	printHeader(message: "Test deck draw one")

	let deck = Deck(isMixed: true)

	print(deck)

	deck.draw()

	print()
	print(deck)
}

func testDeckDrawTwo() {
	printHeader(message: "Test deck draw two")

	let deck = Deck(isMixed: true)

	print(deck)

	deck.draw()
	deck.draw()

	print()
	print(deck)
}

func testDeckDrawAll() {
	printHeader(message: "Test deck draw all")

	let deck = Deck(isMixed: true)

	print(deck)

	for _ in 1...52 {
		deck.draw()
	}

	print()
	print(deck)
}

func testDeckDrawAllMinus() {
	printHeader(message: "Test deck draw all minus")

	let deck = Deck(isMixed: true)

	print(deck)

	for _ in 1...51 {
		deck.draw()
	}

	print()
	print(deck)
}

func testDeckDrawAllPlus() {
	printHeader(message: "Test deck draw all plus")

	let deck = Deck(isMixed: true)

	print(deck)

	for _ in 1...53 {
		deck.draw()
	}

	print()
	print(deck)
}

func testDeckFoldNothing() {
	printHeader(message: "Test deck fold nothing")

	let deck = Deck(isMixed: true)

	print(deck)

	let card = deck.cards[0]
	deck.fold(card: card)

	print()
	print(deck)
}

func testDeckFoldOne() {
	printHeader(message: "Test deck fold one")

	let deck = Deck(isMixed: true)

	print(deck)

	deck.draw()

	print()
	print(deck)

	let card = deck.outs[0]
	deck.fold(card: card)

	print()
	print(deck)
}

func testDeckFoldAll() {
	printHeader(message: "Test deck fold all")

	let deck = Deck(isMixed: true)

	for _ in 1...9 {
		print(deck)

		for _ in 1...6 {
			deck.draw()
		}

		print()
		print(deck)

		for _ in 1...6 {
			if deck.outs.isEmpty == true {
				break
			}

			let count = UInt32(deck.outs.count)
			let index = Int(arc4random_uniform(count))
			let card = deck.outs[index]
			print("    find", card)
			deck.fold(card: card)
		}

		print()
		print(deck)
	}
}

testDeckCardsInitializerFalse()
testDeckCardsInitializerTrue()
testDeckDescription()
testDeckDrawOne()
testDeckDrawTwo()
testDeckDrawAll()
testDeckDrawAllMinus()
testDeckDrawAllPlus()
testDeckFoldNothing()
testDeckFoldOne()
testDeckFoldAll()

