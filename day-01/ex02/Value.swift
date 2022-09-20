//
//  Value.swift
//  CardGame
//
//  Created by Anton Ivanov on 11.08.2022.
//

// MARK: - Value
enum Value: Int {

	case ace = 1
	case two
	case three
	case four
	case five
	case six
	case seven
	case eight
	case nine
	case ten
	case jack
	case queen
	case king

	static let allValue: Values = [.ace, .two, .three, .four, .five, .six, .seven, .eight, .nine, .ten, .jack, .queen, .king]

}

typealias Values = [Value]

