//
//  ViewController.swift
//  DeathNote
//
//  Created by Anton Ivanov on 12.08.2022.
//

import UIKit

class ViewController: UIViewController {

	let id = "identifier"

	@IBOutlet weak var tableView: UITableView!

	@IBAction func buttonPlus(_ sender: UIButton) {
		print("Tap")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.dataSource = self
	}


}

extension ViewController: UITableViewDataSource {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 3
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		var cell = tableView.dequeueReusableCell(withIdentifier: id)

		if cell == nil {
			cell = UITableViewCell(style: .subtitle, reuseIdentifier: id)
		}

		if indexPath.item == 0 {
			cell?.textLabel?.text = "Anton"
			cell?.detailTextLabel?.text = "50 rubles"
		}

		if indexPath.item == 1 {
			cell?.textLabel?.text = "Marina"
			cell?.detailTextLabel?.text = "Dance"
		}

		if indexPath.item == 2 {
			cell?.textLabel?.text = "Lesha"
			cell?.detailTextLabel?.text = "Lexa lepexa"
		}

		return cell!
	}

}

