//
//  MapViewController.swift
//  Day-05
//
//  Created by Anton Ivanov on 18.08.2022.
//

import UIKit
import MapKit


class MapViewController: UIViewController {

	public var plases: Plases?
	public var index: Int = 0
	
	public var currentLocationPerson: CLLocation?

	public lazy var mapView: MKMapView = {
		let mapView = MKMapView()

		mapView.delegate = self
		mapView.showsUserLocation = true

		return mapView
	}()

	private lazy var visualEffectView: UIVisualEffectView = {
		let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.regular)
		let view = UIVisualEffectView(effect: blurEffect)

		view.autoresizingMask = [.flexibleWidth, .flexibleWidth]
		return view
	}()

	private lazy var viewEmpty: UIView = {
		let view = UIView()

		return view
	}()

	private lazy var segmentControl: UISegmentedControl = {
		let segmentControl = UISegmentedControl(
			items: [
				"Standard",
				"Satelite",
				"Hybrid"
			]
		)

		segmentControl.setTitleTextAttributes(
			[
				NSAttributedString.Key.font : UIFont(name: "Arial", size: 14)!,
				NSAttributedString.Key.foregroundColor : UIColor.lightGray
			],
			for: .normal
		)

		segmentControl.setTitleTextAttributes(
			[
				NSAttributedString.Key.font : UIFont(name: "Arial", size: 14)!,
				NSAttributedString.Key.foregroundColor : UIColor.tintColor
			],
			for: .selected
		)

		segmentControl.addTarget(
			self,
			action: #selector(segmentAction),
			for: .valueChanged
		)

		segmentControl.selectedSegmentIndex = 0

		return segmentControl
	}()

	private lazy var viewForButton: UIView = {
		let view = UIView()

		return view
	}()

	private lazy var button: UIButton = {
		let button = UIButton()

		button.frame = CGRect(x: 10, y: 10, width: 20, height: 20)
		button.setBackgroundImage(UIImage(systemName: "location"), for: .normal)
		button.tintColor = .lightGray

		button.addTarget(
			self,
			action: #selector(buttonTouchDown),
			for: .touchDown
		)

		button.addTarget(
			self,
			action: #selector(buttonTouchUpInside),
			for: .touchUpInside
		)

		return button
	}()

	@objc private func buttonTouchUpInside(sender: UIButton) {
		button.tintColor = .lightGray
		LocationManager.shared.setup(self)

		guard let location = currentLocationPerson else {
			return
		}

		self.mapView.setRegion(location: location, distance: 500, animated: true)
		
	}

	@objc private func buttonTouchDown(sender: UIButton) {
		button.tintColor = .tintColor
	}

	private lazy var stackView: UIStackView = {
		let stackView = UIStackView()

		stackView.axis = .horizontal
		stackView.spacing = 20

		return stackView
	}()

	@objc private func segmentAction(sender: UISegmentedControl) {
		switch sender.selectedSegmentIndex {
		case 0:
			self.mapView.mapType = .standard
		case 1:
			self.mapView.mapType = .satellite
		case 2:
			self.mapView.mapType = .hybrid
		default:
			break
		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		self.view.addSubview(self.mapView)
		self.view.addSubview(self.visualEffectView)
		self.view.addSubview(self.stackView)

		self.stackView.addArrangedSubview(self.viewEmpty)
		self.stackView.addArrangedSubview(self.segmentControl)
		self.stackView.addArrangedSubview(self.viewForButton)
		self.viewForButton.addSubview(self.button)

		setupConstraints()

		for plase in self.plases! {
			self.mapView.addAnnotation(plase)
		}

	}

	override func viewDidLayoutSubviews() {

		mapView.frame = self.view.bounds

	}

	override func viewWillAppear(_ animated: Bool) {
		guard let plase = self.plases?[self.index] else {
			return
		}

		self.mapView.setRegion(
			location: CLLocation(
				latitude: plase.coordinate.latitude,
				longitude: plase.coordinate.longitude
			),
			distance: 500,
			animated: animated
		)

	}

	private func setupConstraints() {

		self.visualEffectView.translatesAutoresizingMaskIntoConstraints = false

		let visualEffectViewHeight = self.tabBarController!.tabBar.frame.height * 2 + 100

		NSLayoutConstraint.activate(
			[
				self.visualEffectView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
				self.visualEffectView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
				self.visualEffectView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
				self.visualEffectView.heightAnchor.constraint(equalToConstant: visualEffectViewHeight)
			]
		)

		self.stackView.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate(
			[
				self.stackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
				self.stackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
				self.stackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
				self.stackView.heightAnchor.constraint(equalToConstant: 40)
			]
		)

		NSLayoutConstraint.activate(
			[
				self.viewEmpty.widthAnchor.constraint(equalToConstant: 40),
				self.viewEmpty.heightAnchor.constraint(equalToConstant: 40)
			]
		)

		NSLayoutConstraint.activate(
			[
				self.viewForButton.widthAnchor.constraint(equalToConstant: 40),
				self.viewForButton.heightAnchor.constraint(equalToConstant: 40)
			]
		)

//		NSLayoutConstraint.activate(
//			[
//				self.button.centerXAnchor.constraint(equalTo: self.viewForButton.centerXAnchor),
//				self.button.centerYAnchor.constraint(equalTo: self.viewForButton.centerYAnchor),
//				self.button.widthAnchor.constraint(equalToConstant: 20),
//				self.button.heightAnchor.constraint(equalToConstant: 20)
//			]
//		)

	}


}

