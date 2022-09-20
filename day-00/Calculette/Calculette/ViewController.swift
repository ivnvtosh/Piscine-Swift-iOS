//
//  ViewController.swift
//  Calculette
//
//  Created by Anton Ivanov on 10.08.2022.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var label: UILabel!

	var number: Int?

	var pressed = false
	var pressedDivide = false
	var pressedMultiply = false
	var pressedMinus = false
	var pressedPlus = false
	var pressedEqual = false
	var	newNumber = false

	@IBAction func buttonAC(_ sender: UIButton) {
		label.text = "0"
		number = nil

		pressed = false

		pressedDivide = false
		pressedMultiply = false
		pressedMinus = false
		pressedPlus = false

		buttonDivide.tintColor = .systemOrange
		buttonMultiply.tintColor = .systemOrange
		buttonMinus.tintColor = .systemOrange
		buttonPlus.tintColor = .systemOrange
	}

	@IBAction func buttonNegative(_ sender: UIButton) {
		guard let text = label.text else {
			return
		}

		guard var number = Int(text) else {
			return
		}

		number *= -1

		label.text = String(number)
	}

	@IBOutlet weak var buttonDivide: UIButton!
	@IBOutlet weak var buttonMultiply: UIButton!
	@IBOutlet weak var buttonMinus: UIButton!
	@IBOutlet weak var buttonPlus: UIButton!

	@IBAction func buttonDivideAction(_ sender: UIButton) {
		pressed = true

		newNumber = false

		buttonMultiply.tintColor = .systemOrange
		buttonMinus.tintColor = .systemOrange
		buttonPlus.tintColor = .systemOrange

		if (pressedDivide == true ||
			pressedMultiply  == true ||
			pressedMinus  == true ||
			pressedPlus  == true) &&
			number != nil {

			buttonEqual(sender)
			newNumber = false
			pressed = true
		}

		pressedMultiply = false
		pressedMinus = false
		pressedPlus = false

		pressedDivide = true

		sender.tintColor = .systemGray
	}

	@IBAction func buttonMultiplyAction(_ sender: UIButton) {
		pressed = true

		newNumber = false

		buttonDivide.tintColor = .systemOrange
		buttonMinus.tintColor = .systemOrange
		buttonPlus.tintColor = .systemOrange

		if (pressedDivide == true ||
			pressedMultiply  == true ||
			pressedMinus  == true ||
			pressedPlus  == true) &&
			number != nil {

			buttonEqual(sender)
			newNumber = false
			pressed = true
		}

		pressedDivide = false
		pressedMinus = false
		pressedPlus = false

		pressedMultiply = true

		sender.tintColor = .systemGray
	}

	@IBAction func buttonMinusAction(_ sender: UIButton) {
		pressed = true

		newNumber = false

		buttonDivide.tintColor = .systemOrange
		buttonMultiply.tintColor = .systemOrange
		buttonPlus.tintColor = .systemOrange

		if (pressedDivide == true ||
			pressedMultiply  == true ||
			pressedMinus  == true ||
			pressedPlus  == true) &&
			number != nil {

			buttonEqual(sender)
			newNumber = false
			pressed = true
		}

		pressedDivide = false
		pressedMultiply = false
		pressedPlus = false

		pressedMinus = true

		sender.tintColor = .systemGray
	}

	@IBAction func buttonPlusAction(_ sender: UIButton) {
		pressed = true

		newNumber = false

		buttonDivide.tintColor = .systemOrange
		buttonMultiply.tintColor = .systemOrange
		buttonMinus.tintColor = .systemOrange

		if (pressedDivide == true ||
			pressedMultiply  == true ||
			pressedMinus  == true ||
			pressedPlus  == true) &&
			number != nil {

			buttonEqual(sender)
			newNumber = false
			pressed = true
		}

		pressedDivide = false
		pressedMultiply = false
		pressedMinus = false

		pressedPlus = true

		sender.tintColor = .systemGray
	}

	@IBAction func buttonEqual(_ sender: UIButton) {
		guard let text = label.text else {
			return
		}

		guard let numberOne = number else {
			return
		}

		guard let numberTwo = Int(text) else {
			return
		}

		defer {
			number = nil

			pressed = false

			pressedDivide = false
			pressedMultiply = false
			pressedMinus = false
			pressedPlus = false

			newNumber = true

			buttonDivide.tintColor = .systemOrange
			buttonMultiply.tintColor = .systemOrange
			buttonMinus.tintColor = .systemOrange
			buttonPlus.tintColor = .systemOrange
		}

		var result = 0

		if pressedDivide == true {
			if numberTwo == 0 {
				label.text = "Error"
				return
			}

			result = numberOne / numberTwo
		}

		if pressedMultiply == true {
			result = numberOne &* numberTwo
		}

		if pressedMinus == true {
			result = numberOne &- numberTwo
		}

		if pressedPlus == true {
			result = numberOne &+ numberTwo
		}

		label.text = String(result)

	}



	func add(digit: String) {
		guard let text = label.text else {
			return
		}


		if newNumber == true {
			newNumber = false
			label.text = digit
			return
		}

		if pressed == true, number == nil {
			pressed = false

			buttonDivide.tintColor = .systemOrange
			buttonMultiply.tintColor = .systemOrange
			buttonMinus.tintColor = .systemOrange
			buttonPlus.tintColor = .systemOrange

			number = Int(text)
			label.text = digit
			return
		}

		if text.count == 9 {
			return
		}

		if text == "0" || text == "Error" {
			label.text = digit
			return
		}

		label.text = text + digit
	}

	@IBAction func button9(_ sender: UIButton) {
		add(digit: "9")
	}

	@IBAction func button8(_ sender: UIButton) {
		add(digit: "8")
	}

	@IBAction func button7(_ sender: UIButton) {
		add(digit: "7")
	}

	@IBAction func button6(_ sender: UIButton) {
		add(digit: "6")
	}

	@IBAction func button5(_ sender: UIButton) {
		add(digit: "5")
	}

	@IBAction func button4(_ sender: UIButton) {
		add(digit: "4")
	}

	@IBAction func button3(_ sender: UIButton) {
		add(digit: "3")
	}

	@IBAction func button2(_ sender: UIButton) {
		add(digit: "2")
	}

	@IBAction func button1(_ sender: UIButton) {
		add(digit: "1")
	}

	@IBAction func button0(_ sender: UIButton) {
		add(digit: "0")
	}

	@IBOutlet weak var stackView: UIStackView!
//
//	override func viewDidLayoutSubviews() {
//		NSLayoutConstraint.activate([
//			stackView.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.75),
//			stackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
//			stackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
//			stackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
//		])
//	}

//	override func viewWillLayoutSubviews() {
//		NSLayoutConstraint.activate([
//			stackView.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.75),
//			stackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 160),
//			stackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
//			stackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
//		])
//	}
//
//	override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//		if UIDevice.current.orientation.isLandscape {
//			print("Landscape")
//		} else {
//			print("Portrait")
//		}
//	}

	override func viewDidLoad() {
		super.viewDidLoad()

		// Do any additional setup after loading the view.
	}


}

