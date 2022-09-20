//
//  ViewController.swift
//  DeathNote
//
//  Created by Anton Ivanov on 12.08.2022.
//

import UIKit

class ViewController: UIViewController {

	var notes = [Note(name: "Anton", description: "50 rubles"),
				 Note(name: "Marina", description: "Dance"),
				 Note(name: "Lesha", description: "Lepexa"),
				]

	let cellId = "TableViewCellNote"
	let segueId = "segueIdentifier"

	@IBOutlet weak var tableView: UITableView!

	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.dataSource = self
		tableView.delegate = self

		let nib = UINib(nibName: cellId, bundle: nil)
		tableView.register(nib, forCellReuseIdentifier: cellId)
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == segueId {
//			segue.destination
		}
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
		cell?.labelDescription.text = notes[indexPath.row].description
		cell?.labelTimeOfLastVisit.text = notes[indexPath.row].timeOfLastVisit.description.cropEnd(count: 6)

		return cell!
	}

}

extension String {

	func cropEnd(count: Int) -> String {
		let endIndex = self.index(self.endIndex, offsetBy: -count)
		let string = String(self[..<endIndex])

		return string
	}

}

extension ViewController: UITableViewDelegate {

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 80
	}

}

