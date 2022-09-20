//
//  Color.swift
//  CardGame
//
//  Created by Anton Ivanov on 11.08.2022.
//

// MARK: - Color
enum Color: String {

	case spades
	case diamonds
	case hearts
	case clubs

	static let allColor: Colors = [.spades, .diamonds, .hearts, .clubs]

}

typealias Colors = [Color]

