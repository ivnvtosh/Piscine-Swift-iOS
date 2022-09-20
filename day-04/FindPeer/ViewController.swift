//
//  ViewController.swift
//  FindPeer
//
//  Created by Anton Ivanov on 29.07.2022.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var textFieldLogin: UITextField!

	@IBOutlet weak var displayName: UILabel!
	@IBOutlet weak var labelLogin: UILabel!
	
	@IBOutlet weak var labelWallet: UILabel!
	@IBOutlet weak var labelEvaluationPoints: UILabel!
	
	@IBOutlet weak var labelLevel: UILabel!
	@IBOutlet weak var viewLevel: UIView!
	@IBOutlet weak var viewBackgroundLevel: UIView!
	
	
	@IBOutlet weak var labelUnavailable: UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()

		initToken()

		textFieldLogin.delegate = self
	}

	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		self.view.endEditing(true)
		return false
	}

	func initToken () {
		ApiManager.shared.getToken { token in
			guard let token = token else {
				return
			}

			accessToken = token.accessToken!

		}
		sleep(1)
	}

	func fillLevel(_ level: Float?) {
		guard let level = level else {
			return
		}

		self.labelLevel.text = "level " + String(Int(floor(level))) + " - " + String(Int(level.truncatingRemainder(dividingBy: 1) * 100)) + "%"
		
		self.viewLevel.frame = CGRect(x: self.viewLevel.frame.origin.x,
									  y: self.viewLevel.frame.origin.y,
									  width: self.viewBackgroundLevel.frame.width * CGFloat(level.truncatingRemainder(dividingBy: 1)),
									  height: self.viewLevel.frame.height)
	}

	func performSearch(with login: String) {
		ApiManager.shared.getUser(login: login) { user in
			guard let user = user else {
				return
			}

			self.displayName.text = user.displayname!
			self.labelLogin.text = user.login!
			self.labelWallet.text = String(user.wallet!)
			self.labelEvaluationPoints.text = String(user.correctionPoint!)
			self.labelUnavailable.text = user.location ?? "Unavailable"
			self.fillLevel(user.cursusUser[1].level)
			
			print(user)
			print()
			print(user.displayname ?? "no data", user.login ?? "no data")
			print()
			print("Wallet   :", user.wallet ?? "no data")
			print("Point    :", user.correctionPoint ?? "no data")
			print("Location :", user.location ?? "Unavailable")
			print("URL      :", user.url ?? "no data")
			print("Level    :", user.cursusUser[1].level ?? "no data")
			print()

		}

	}
	
}

extension ViewController: UITextFieldDelegate {

	@IBAction func editingDidEndLogin(_ sender: UITextField) {
		guard let login = sender.text else {
			return
		}

		performSearch(with: login)
		view.endEditing(true)

	}

	
	
	
}
