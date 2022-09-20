//
//  ListViewController.swift
//  Day-05
//
//  Created by Anton Ivanov on 18.08.2022.
//

import UIKit
import MapKit

class ListViewController: UIViewController {

	private let cellID = "ListTableViewCellasd"

	public var plases: Plases?

	private lazy var tableView: UITableView = {
		let tableView = UITableView()

		tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
		tableView.dataSource = self
		tableView.delegate = self

		return tableView
	}()

    override func viewDidLoad() {
        super.viewDidLoad()

		self.view.addSubview(self.tableView)
    }

	override func viewDidLayoutSubviews() {

		tableView.frame = self.view.bounds

	}


}


extension ListViewController: UITableViewDataSource {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return plases!.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		var cell = tableView.dequeueReusableCell(withIdentifier: cellID)

		if cell == nil {
			cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellID)
		}

		cell?.textLabel?.text = plases![indexPath.row].title

		return cell!
	}


}


extension ListViewController: UITableViewDelegate {

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)

		guard let viewController =  self.tabBarController?.viewControllers?[0] else {
			return
		}

		guard let mapViewController = viewController as? MapViewController else {
			return
		}

		mapViewController.index = indexPath.row
		self.tabBarController?.selectedViewController = viewController
	}

}

