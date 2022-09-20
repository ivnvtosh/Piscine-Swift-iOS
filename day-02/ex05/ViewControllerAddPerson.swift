//
//  ViewControllerAddPerson.swift
//  DeathNote
//
//  Created by Anton Ivanov on 13.08.2022.
//

import UIKit


class ViewControllerAddPerson: UIViewController {

	let performSegue = "prepareForUnwindWithSegue"

	weak var delegate: ViewControllerDelegate?

	var name: String?
	var descriptionOfDeath: String?
	var date: Date = .now

	@IBOutlet weak var textViewDescription: UITextView!
	@IBOutlet weak var dataPicker: UIDatePicker!
	
	@IBAction func prepareForUnwind(segue: UIStoryboardSegue) {
		self.performSegue(withIdentifier: performSegue, sender: self)
	}

	@IBAction func doneAction(_ sender: UIBarButtonItem) {
		guard let name = name else {
			self.navigationController?.popToRootViewController(animated: true)
			return
		}

		if name.isEmpty == true {
			self.navigationController?.popToRootViewController(animated: true)
			return
		}

		descriptionOfDeath = textViewDescription.text
		let note = Note(name: name, descriptionOfDeath: descriptionOfDeath ?? "", dateOfDeath: date)
		print(note)

		delegate?.update(note: note)
		self.navigationController?.popToRootViewController(animated: true)
	}

	@IBAction func textFieldNameAction(_ sender: UITextField) {
		name = sender.text
	}

	@IBAction func dataPickerAction(_ sender: UIDatePicker) {
		date = sender.date
	}

	override func viewDidLoad() {
        super.viewDidLoad()
		
		dataPicker.minimumDate = .now

		textViewDescription.layer.borderWidth = 1
		textViewDescription.layer.borderColor = UIColor.systemGray6.cgColor
		textViewDescription.layer.cornerRadius = 5
    }
    
}
