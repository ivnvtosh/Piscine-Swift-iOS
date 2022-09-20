//
//  CoreMap.swift
//  Day-05
//
//  Created by Anton Ivanov on 19.08.2022.
//

import UIKit
import MapKit


extension MKMapView {

	public func setRegion(location: CLLocation, distance: CLLocationDistance, animated: Bool) {
		let coordinateRegion = MKCoordinateRegion(
			center: location.coordinate,
			latitudinalMeters: distance,
			longitudinalMeters: distance
		)

		self.setRegion(coordinateRegion, animated: animated)
	}


}


extension MapViewController: MKMapViewDelegate {

	public func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
		guard let annotation = annotation as? Plase else {
			return nil
		}

		let annotationID = "sgylfhjkhalrknmcdvghrlvdasdfdsfdfas"

		var view = mapView.dequeueReusableAnnotationView(withIdentifier: annotationID) as? MKMarkerAnnotationView

		if view == nil {
			view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: annotationID)
		}

		view!.animatesWhenAdded = true
		view!.glyphImage = UIImage(systemName: "graduationcap.fill")
		switch annotation.title {
		case "Школа 21 Москва":
			view!.markerTintColor = .red
		case "Школа 21 Казань":
			view!.markerTintColor = .yellow
		case "Школа 21 Новосибирск":
			view!.markerTintColor = .blue
		default:
			view!.markerTintColor = .purple
		}

		view!.annotation = annotation

		view!.canShowCallout = true
		view!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)

		return view!
	}


}

