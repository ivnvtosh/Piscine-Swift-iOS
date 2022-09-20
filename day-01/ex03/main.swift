//
//  main.swift
//  CardGame
//
//  Created by Anton Ivanov on 12.08.2022.
//

func printHeader(message: String) {
	print("--------------------")
	print(message)
	print("--------------------")
}

func testArrayMixedOne() {
	printHeader(message: "Test Array mixed one")

	var array = [0, 1, 2, 3, 4, 5]

	print(array)
	array.mixed()
	print(array)
}

func testArrayMixedTwo() {
	printHeader(message: "Test Array mixed two")

	var array = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

	print(array)
	array.mixed()
	print(array)
}

testArrayMixedOne()
testArrayMixedTwo()

