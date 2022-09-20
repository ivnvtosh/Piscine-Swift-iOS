//
//  CoreLocation.swift
//  Day-05
//
//  Created by Anton Ivanov on 19.08.2022.
//

import UIKit
import CoreLocation


//    MARK: - LocationManager
class LocationManager {

	static let shared = LocationManager()

	public let locationManager = CLLocationManager()

	public func setup(_ delegate: CLLocationManagerDelegate) {
		self.locationManager.delegate = delegate
		self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
		self.locationManager.distanceFilter = 10
		self.locationManager.startUpdatingLocation()
	}

	public func requestAuthorization() {
		self.locationManager.requestWhenInUseAuthorization()
	}


}


extension MapViewController: CLLocationManagerDelegate {

	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		self.currentLocationPerson = locations.last
	}


}

