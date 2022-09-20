//
//  main.swift
//  CardGame
//
//  Created by Anton Ivanov on 12.08.2022.
//

func printHeader(message: String) {
	print("--------------")
	print(message)
	print("--------------")
}

func testColorOne() {
	printHeader(message: "Test color one")

	print(Color.spades)
	print(Color.diamonds)
	print(Color.hearts)
	print(Color.clubs)
}

func testColorAll() {
	printHeader(message: "Test color all")

	print(Color.allColor[0])
	print(Color.allColor[1])
	print(Color.allColor[2])
	print(Color.allColor[3])
}

func testValueOne() {
	printHeader(message: "Test value one")

	print(Value.ace, Value.ace.rawValue)
	print(Value.two, Value.two.rawValue)
	print(Value.three, Value.three.rawValue)
	print(Value.four, Value.four.rawValue)
	print(Value.five, Value.five.rawValue)
	print(Value.six, Value.six.rawValue)
	print(Value.seven, Value.seven.rawValue)
	print(Value.eight, Value.eight.rawValue)
	print(Value.nine, Value.nine.rawValue)
	print(Value.ten, Value.ten.rawValue)
	print(Value.jack, Value.jack.rawValue)
	print(Value.queen, Value.queen.rawValue)
	print(Value.king, Value.king.rawValue)
}

func testValueAll() {
	printHeader(message: "Test value all")

	print(Value.allValue[0], Value.allValue[0].rawValue)
	print(Value.allValue[1], Value.allValue[1].rawValue)
	print(Value.allValue[2], Value.allValue[2].rawValue)
	print(Value.allValue[3], Value.allValue[3].rawValue)
	print(Value.allValue[4], Value.allValue[4].rawValue)
	print(Value.allValue[5], Value.allValue[5].rawValue)
	print(Value.allValue[6], Value.allValue[6].rawValue)
	print(Value.allValue[7], Value.allValue[7].rawValue)
	print(Value.allValue[8], Value.allValue[8].rawValue)
	print(Value.allValue[9], Value.allValue[9].rawValue)
	print(Value.allValue[10], Value.allValue[10].rawValue)
	print(Value.allValue[11], Value.allValue[11].rawValue)
	print(Value.allValue[12], Value.allValue[12].rawValue)
}

testColorOne()
testColorAll()

testValueOne()
testValueAll()

