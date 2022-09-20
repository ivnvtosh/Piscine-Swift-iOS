//
//  ViewController.swift
//  testView
//
//  Created by Dmitry Kaveshnikov on 25/8/22.
//

import Foundation
import UIKit
import MapKit
import LocalAuthentication

protocol ViewControllerDelegate {
    func configure(coordinateStart: CLLocationCoordinate2D, coordinateEnd: CLLocationCoordinate2D)
	func createSearchPin(coordinate: CLLocationCoordinate2D)
}

class MapViewController: UIViewController, ViewControllerDelegate {
 
    //properties
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 7000
    var authStatus: CLAuthorizationStatus?
    var previousLocation: CLLocation?
    var directionsArray: [MKDirections] = []
    
    //MARK: - UIElements
    
    let  mapView: MKMapView = {
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()
    
    let segmentBar: UISegmentedControl = {
        let bar = UISegmentedControl(items: K.itemsControl)
        bar.addTarget(self, action: #selector(changeSegmentedControl), for: .valueChanged)
        bar.translatesAutoresizingMaskIntoConstraints = false
        return bar
    }()
    
    let  locationButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "scope"), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: #selector(locationButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //pin
    let pin: UIImageView = {
        let pin = UIImageView()
        pin.image = UIImage(systemName: "mappin")
        pin.tintColor = .systemPurple
        pin.contentMode = .scaleAspectFit
        pin.translatesAutoresizingMaskIntoConstraints = false
        return pin
    }()
    
    //label
    let labelLocation: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.backgroundColor = .white
        label.text = "test test test"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let labelDirections: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.layer.cornerRadius = 5
        label.numberOfLines = 0
        label.layer.masksToBounds = true
        label.isHidden = true
        label.backgroundColor = .systemBlue
        label.text = "test test test"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    //go button
    let button: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 12.4
        button.setTitle("GO", for: .normal)
        button.backgroundColor = .systemMint
        button.addTarget(self, action: #selector(goButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    //del button
    let buttonDelete: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 12.4
        button.setTitle("Del", for: .normal)
        button.backgroundColor = .systemRed
        button.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //search button
    let searchButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 12.4
        button.setImage(UIImage(systemName: "magnifyingglass.circle.fill"), for: .normal)
        button.tintColor = .purple
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()
        view.addSubview(mapView)
        setupMapConstraints()
        setupControl()
        print(UIScreen.main.bounds.size)
        mapView.delegate = self
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPress))
        longPress.minimumPressDuration = 1.5
        mapView.addGestureRecognizer(longPress)
    }
	
    //MARK: - Constraints
    
    func setupControl() {
        mapView.addSubviews([segmentBar, locationButton, labelLocation, button, buttonDelete, searchButton, labelDirections])
        setupConstraints()
    }
    
    //MARK: - Methods
    //delegate
    
    func configure(coordinateStart: CLLocationCoordinate2D, coordinateEnd: CLLocationCoordinate2D) {
        print (coordinateStart)
        print ("keke\(coordinateEnd)")
		let newPinStart = MKPointAnnotation()
		let newPinEnd = MKPointAnnotation()
		newPinStart.coordinate = coordinateStart
		newPinEnd.coordinate = coordinateEnd
		DispatchQueue.main.async {
			let annotation = self.mapView.annotations
			self.mapView.removeAnnotations(annotation)

			self.mapView.addAnnotations([newPinStart, newPinEnd])
			let region = MKCoordinateRegion(center: coordinateStart, latitudinalMeters: 1000, longitudinalMeters: 1000)
			self.mapView.setRegion(region, animated: true)
        }
		getDirections(coordinateStart, coordinateEnd)
		centerViewOnPin(coordinateStart)
    }
    
    //map
    @objc func locationButtonTapped() {
        guard let location = locationManager.location?.coordinate else { return }
        DispatchQueue.main.async {
            self.mapView.setRegion(MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)), animated: true)
        }
    }
    
    func loadMap() {
        guard let location = locationManager.location?.coordinate else { return }
        DispatchQueue.main.async {
            self.mapView.setRegion(MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)), animated: true)
        }
    }

    @objc func changeSegmentedControl(_ sender: UISegmentedControl) {
        switch (sender.selectedSegmentIndex) {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .satellite
        case 2:
            mapView.mapType = .hybrid
        default:
            break
        }
    }
    
    func checkAutorization() {
        if #available(iOS 14, *) {
            authStatus = locationManager.authorizationStatus
        } else {
            authStatus = CLLocationManager.authorizationStatus()
        }
        switch authStatus {
        case .authorizedWhenInUse:
            startTrackingUserLocation()
            centerViewOnUserLocation()
            loadMap()
        case .denied:
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            break
        case .authorizedAlways:
            break
        default:
            break
        }
    }
    
    func startTrackingUserLocation() {
        mapView.showsUserLocation = true
        centerViewOnUserLocation()
        locationManager.startUpdatingLocation()
        previousLocation = getCenterLocation(mapView)
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkAutorization()
        } else {
            //show allert
        }
    }
    
    func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
        }
    }

	func centerViewOnPin(_ location: CLLocationCoordinate2D) {
		let region = MKCoordinateRegion(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
		mapView.setRegion(region, animated: true)
	}

    func getCenterLocation(_ mapView: MKMapView) -> CLLocation {
        let latitude = mapView.centerCoordinate.latitude
        let longitude = mapView.centerCoordinate.longitude
        return CLLocation(latitude: latitude, longitude: longitude)
    }

    func getPinLocation(_ mapView: MKMapView) -> CLLocation? {
        let defaultAnnotation = MKPointAnnotation()
		guard let location = locationManager.location else { return CLLocation(latitude: 55.797138, longitude: 37.579828)}
        defaultAnnotation.coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        if mapView.annotations.isEmpty {
            return CLLocation(latitude: defaultAnnotation.coordinate.latitude, longitude: defaultAnnotation.coordinate.longitude)
            //            mapView.annotations.append(defaultAnnotation)
        }
        let newPin = mapView.annotations[0]
        let latitude = newPin.coordinate.latitude
        let longitude = newPin.coordinate.longitude
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    //navigator
    func getDirections() {
        guard let location = locationManager.location?.coordinate else {
            return
        }
        let request = createDirectionsRequest(from: location)
        let directions = MKDirections(request: request)
        resetMapView(with: directions)
        directions.calculate { [unowned self] (response, error) in
            guard let response = response else { return }
            let route = response.routes[0]
                //to do create Table view with this data
                self.mapView.addOverlay(route.polyline)
            let expectedTime = Int(route.expectedTravelTime / 60)
            labelDirections.text = " Approximate time to destination: \(expectedTime) minutes 🤪 "
                labelDirections.isHidden = false
//                self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
        }
    }

	func getDirections(_ locationStart: CLLocationCoordinate2D, _ locationEnd: CLLocationCoordinate2D) {

		let request = createDirectionsRequest(from: locationStart, to: locationEnd)
		let directions = MKDirections(request: request)
		resetMapView(with: directions)
		directions.calculate { [unowned self] (response, error) in
			guard let response = response else { return }
			
			let route = response.routes[0]
			//to do create Table view with this data
//				let steps = route.steps
			print("ROUTE1", route.expectedTravelTime)
//				print(steps)
			self.mapView.addOverlay(route.polyline)
			self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
		}
	}
	
	func createDirectionsRequest(from coordinateFrom: CLLocationCoordinate2D, to coordinateTo: CLLocationCoordinate2D) -> MKDirections.Request {
		
//        let destinationCoordinate = getCenterLocation(mapView).coordinate
		let destinationCoordinate = coordinateTo
		let startingCoordinate = MKPlacemark(coordinate: coordinateFrom)
		let destanation = MKPlacemark(coordinate: destinationCoordinate)
		let request = MKDirections.Request()
		request.source = MKMapItem(placemark: startingCoordinate)
		request.destination = MKMapItem(placemark: destanation)
		request.transportType = .any
		request.requestsAlternateRoutes = true
		return request
	}

    func createDirectionsRequest(from coordinate: CLLocationCoordinate2D) -> MKDirections.Request {
        
//        let destinationCoordinate = getCenterLocation(mapView).coordinate
        let destinationCoordinate = getPinLocation(mapView)!.coordinate
        let startingCoordinate = MKPlacemark(coordinate: coordinate)
        let destanation = MKPlacemark(coordinate: destinationCoordinate)
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: startingCoordinate)
        request.destination = MKMapItem(placemark: destanation)
        request.transportType = .any
        request.requestsAlternateRoutes = true
        return request
        
    }
    //reset routes
    func resetMapView(with directions: MKDirections) {
        mapView.removeOverlays(mapView.overlays)
        directionsArray.append(directions)
        let _ = directionsArray.map { $0.cancel() }
        DispatchQueue.main.async {
            self.labelDirections.text = ""
            self.labelDirections.isHidden = true
        }
    }
    
    @objc func goButtonTapped() {
        getDirections()
        DispatchQueue.main.async {
            self.centerViewOnUserLocation()
        }
//        showDirections()
    }
    
    func createSearchPin(coordinate: CLLocationCoordinate2D) {
        print("NEW PIN", coordinate)
        let newPin = MKPointAnnotation()
        newPin.coordinate = coordinate
        DispatchQueue.main.async {
            let annotation = self.mapView.annotations
            self.mapView.removeAnnotations(annotation)

            self.mapView.addAnnotation(newPin)
            let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
            self.mapView.setRegion(region, animated: true)
        }
    }
    
    //long press tapped
    
    @objc func longPress(_ recognizer: UIGestureRecognizer) {
        print("long pressssssss")
            let touchedAt = recognizer.location(in: mapView)
            let touchedAtCoordinate : CLLocationCoordinate2D = mapView.convert(touchedAt, toCoordinateFrom: mapView)
            let newPin = MKPointAnnotation()
            newPin.coordinate = touchedAtCoordinate
            mapView.addAnnotation(newPin)
    }
    
    @objc func deleteButtonTapped() {
        guard let location = locationManager.location?.coordinate else { return }
        let annotation = mapView.annotations
        mapView.removeAnnotations(annotation)
        let request = createDirectionsRequest(from: location)
        let directions = MKDirections(request: request)
        resetMapView(with: directions)
    }
    
    @objc func searchButtonTapped() {
        let newVC = SearchDirectionsViewController()
//        newVC.transitioningDelegate = slideInTransitioningManager
        if let sheet = newVC.sheetPresentationController {
            sheet.detents = [.medium()]
        }
		newVC.delegate = self
        present(newVC, animated: true, completion: nil)
    }
}

extension MapViewController: CLLocationManagerDelegate, MKMapViewDelegate {

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkAutorization()
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let center = getCenterLocation(mapView)
        let geocoder = CLGeocoder()
        guard let pinCoordinates = getPinLocation(mapView) else { return }
        guard let previousLocation = self.previousLocation else { return }
        guard pinCoordinates.distance(from: previousLocation ) > 50 else { return }
        self.previousLocation = center
        geocoder.reverseGeocodeLocation(pinCoordinates) { [weak self] (placemark, error) in
            guard let self = self else { return }
            if let _ = error { return }
            guard let placemark = placemark?.first else {
                return
            }
            let streetNumber = placemark.subThoroughfare ?? ""
            let streetName = placemark.thoroughfare ?? ""
            DispatchQueue.main.async {
                self.labelLocation.text = " \(streetNumber) \(streetName)"
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = .systemBlue
        return renderer
    }
}
