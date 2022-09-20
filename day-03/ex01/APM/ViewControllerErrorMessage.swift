//
//  ViewControllerErrorMessage.swift
//  APM
//
//  Created by Anton Ivanov on 14.08.2022.
//

import UIKit

class ViewControllerErrorMessage: UIViewController {

	@IBOutlet weak var viewBackGround: UIView!
	@IBOutlet weak var label: UILabel!
	@IBOutlet weak var labelDescription: UILabel!

	var descriptionText = ""

	@IBAction func button(_ sender: UIButton) {
		dismiss(animated: true, completion: nil)
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		labelDescription.text = descriptionText
		viewBackGround.layer.cornerRadius = 10
	}


	/*
	// MARK: - Navigation

	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		// Get the new view controller using segue.destination.
		// Pass the selected object to the new view controller.
	}
	*/

}
