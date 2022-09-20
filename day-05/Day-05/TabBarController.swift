//
//  TapBarController.swift
//  Day-05
//
//  Created by Anton Ivanov on 18.08.2022.
//

import UIKit
import CoreLocation


class TabBarController: UITabBarController {

	public var plases: Plases = [
		Plase(
			title: "Школа 21 Москва",
			subtitle: "Программисты",
			coordinate:  CLLocationCoordinate2D(
				latitude: 55.797138,
				longitude: 37.579828
			)
		),
		Plase(
			title: "Школа 21 Казань",
			subtitle: "Программисты",
			coordinate:  CLLocationCoordinate2D(
				latitude: 55.781977,
				longitude: 49.125081
			)
		),
		Plase(
			title: "Школа 21 Новосибирск",
			subtitle: "Программисты",
			coordinate:  CLLocationCoordinate2D(
				latitude: 54.980324,
				longitude: 82.897845
			)
		),
	]

	override func viewDidLoad() {
		super.viewDidLoad()

		generateTabBar()
	}

	private func generateTabBar() {
		let mapViewController = MapViewController()
		let listViewController = ListViewController()

		mapViewController.plases = plases
		listViewController.plases = plases

		self.viewControllers = [
			generateViewController(
				viewController: mapViewController,
				title: "Map",
				image: UIImage(systemName: "map.circle.fill")
			),
			generateViewController(
				viewController: listViewController,
				title: "List",
				image: UIImage(systemName: "list.bullet.circle.fill")
			),
			generateViewController(
				viewController: MoreViewController(),
				title: "More",
				image: UIImage(systemName: "ellipsis.circle.fill")
			),
		]
	}

	private func generateViewController(viewController: UIViewController, title: String, image: UIImage?) -> UIViewController {

		viewController.tabBarItem.title = title

		guard let image = image else {
			viewController.tabBarItem.image = UIImage(systemName: "exclamationmark.circle.fill")
			return viewController
		}

		viewController.tabBarItem.image = image
		return viewController
	}


}

