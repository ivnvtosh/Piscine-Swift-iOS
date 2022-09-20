//
//  ViewController.swift
//  DeathNote
//
//  Created by Anton Ivanov on 12.08.2022.
//

import UIKit

class ViewController: UIViewController {

	var notes = [Note(name: "Masha", descriptionOfDeath: "The anvil fell", dateOfDeath: .now),
				 Note(name: "Sasha", descriptionOfDeath: "Duper dance", dateOfDeath: .now),
				 Note(name: "Igor", descriptionOfDeath: "Car", dateOfDeath: .now),
				]

	let cellId = "TableViewCellNote"
	let segueId = "segueIdentifier"

	@IBOutlet weak var tableView: UITableView!

	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.dataSource = self

		let nib = UINib(nibName: cellId, bundle: nil)
		tableView.register(nib, forCellReuseIdentifier: cellId)
	}

}

protocol ViewControllerDelegate: AnyObject {

	func update(note: Note)

}

extension ViewController: ViewControllerDelegate {

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		guard let destination = segue.destination as? ViewControllerAddPerson else {
			return
			
		}

		destination.delegate = self
	}
	
	func update(note: Note) {
		notes.insert(note, at: 0)
		tableView.reloadData()
	}

}

extension ViewController: UITableViewDataSource {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return notes.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		var cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! TableViewCellNote?

		if cell == nil {
			cell = TableViewCellNote(style: .subtitle, reuseIdentifier: cellId)
		}

		cell?.labelName.text = notes[indexPath.row].name
		cell?.labelDescription.text = notes[indexPath.row].descriptionOfDeath
		cell?.labelTimeOfLastVisit.text = notes[indexPath.row].dateOfDeath.formatted(date: .numeric, time: .shortened)

		return cell!
	}

}

