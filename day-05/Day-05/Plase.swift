//
//  Plase.swift
//  Day-05
//
//  Created by Anton Ivanov on 19.08.2022.
//

import UIKit
import MapKit


//    MARK: - Plase
class Plase: NSObject, MKAnnotation {

	public let title: String?
	public let subtitle: String?
	public let coordinate: CLLocationCoordinate2D

	init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D) {
		self.title = title
		self.subtitle = subtitle
		self.coordinate = coordinate

		super.init()
	}


}


typealias Plases = [Plase]

