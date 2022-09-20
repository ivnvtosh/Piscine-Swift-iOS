//
//  ViewController.swift
//  DeathNote
//
//  Created by Anton Ivanov on 12.08.2022.
//

import UIKit

class ViewController: UIViewController {

	var notes = [Note(name: "Lol", descriptionOfDeath: "50 rubles", dateOfDeath: Date()),
				 Note(name: "Kek", descriptionOfDeath: "Dance", dateOfDeath: Date()),
				 Note(name: "Mkl", descriptionOfDeath: "Lepexa", dateOfDeath: Date()),
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

//	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//		print(segue.identifier!)
//		if segue.identifier == segueId {
//			let source = segue.source as! ViewController
////			source.notes.append(note!)
//			print("lol")
//		}
//	}

//	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//	   if segue.identifier == "prepareForUnwindWithSegue" {
//		   let destination = segue.destination as! ViewControllerAddPerson
//		   notes.append(destination.note!)
//		   print("lol")
//	   }
//		print(segue.identifier)
//		print("kek")
//	}

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
		notes.append(note)
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

extension ViewController: UITableViewDelegate {

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 80
	}

}

