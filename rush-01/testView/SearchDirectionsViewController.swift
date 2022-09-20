//
//  SearchDirectionsViewController.swift
//  testView
//
//  Created by Dmitry Kaveshnikov on 25/8/22.
//

import Foundation
import UIKit
import MapKit

class SearchDirectionsViewController: UIViewController {
    
    var delegate: ViewControllerDelegate?
    let locationManager = CLLocationManager()
    
    let searchBar : UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.sizeToFit()
        searchBar.placeholder = "Search Maps"
        searchBar.searchTextField.textColor = .white
        searchBar.barTintColor = .darkGray
        searchBar.setBackgroundImage(UIImage.init(), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
        searchBar.isTranslucent = true
        searchBar.layer.cornerRadius = 5
		searchBar.searchTextField.addTarget(self, action: #selector(getSearchCoordinates), for: .editingDidEndOnExit)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()

    let segmentBar: UISegmentedControl = {
        let bar = UISegmentedControl(items: K.itemsControl)
        bar.isHidden = true
        bar.layer.cornerRadius = 5
        bar.translatesAutoresizingMaskIntoConstraints = false
        return bar
    }()
    
    let startLocationText: UITextField = {
        let field = UITextField()
        field.placeholder = "start"
        field.layer.cornerRadius = 5
        field.backgroundColor = .white
        field.textColor = .black
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    let destanationLocationText: UITextField = {
        let field = UITextField()
        field.placeholder = "finish"
        field.layer.cornerRadius = 5
        field.backgroundColor = .white
        field.textColor = .black
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    let button: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 12.4
        button.setTitle("GO", for: .normal)
        button.backgroundColor = .systemGreen
        button.addTarget(self, action: #selector(goButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let smallButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 12.4
        button.setTitle("GO", for: .normal)
        button.backgroundColor = .systemGreen
        button.addTarget(self, action: #selector(getSearchCoordinatesButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }
    
    func setupView () {
        view.backgroundColor = .darkGray
        view.addSubviews([searchBar, segmentBar, startLocationText, destanationLocationText, button, smallButton])
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            searchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            searchBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            searchBar.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -60),
            searchBar.heightAnchor.constraint(equalToConstant: 40),
            
            smallButton.topAnchor.constraint(equalTo: searchBar.topAnchor),
            smallButton.bottomAnchor.constraint(equalTo: searchBar.bottomAnchor),
            smallButton.leftAnchor.constraint(equalTo: searchBar.rightAnchor, constant: 10),
            smallButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
            
            segmentBar.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 20),
            segmentBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            segmentBar.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            segmentBar.heightAnchor.constraint(equalToConstant: 30),
            
            startLocationText.topAnchor.constraint(equalTo: segmentBar.bottomAnchor, constant: 30),
            startLocationText.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            startLocationText.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            startLocationText.heightAnchor.constraint(equalToConstant: 40),
            
            destanationLocationText.topAnchor.constraint(equalTo: startLocationText.bottomAnchor, constant: 10),
            destanationLocationText.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            destanationLocationText.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            destanationLocationText.heightAnchor.constraint(equalToConstant: 40),
            
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            button.heightAnchor.constraint(equalToConstant: 150),
            button.widthAnchor.constraint(equalTo: button.heightAnchor),
        ])
    }
    
    
    @objc func goButtonTapped() {
        let map = MapViewController()
        guard let startAdress = startLocationText.text else { return }
        guard let endAdress = destanationLocationText.text else { return }
        
		getCoordinates(startAdress, map.mapView) { resultStart in
			guard let resultStart = resultStart else { return }
			
			self.getCoordinates(endAdress, map.mapView) { resultEnd in
				guard let resultEnd = resultEnd else { return }
				self.delegate?.configure(coordinateStart: resultStart, coordinateEnd: resultEnd)
				DispatchQueue.main.async {
					self.dismiss(animated: true)
				}
            }
        }
	}
    
    @objc func getSearchCoordinates(_ sender: UITextField) {
        guard let text = sender.text else { return }
        let map = MapViewController()
        getCoordinates(text, map.mapView) { result in
            guard let result = result else { return }
            self.delegate?.createSearchPin(coordinate: result)
            self.dismiss(animated: true)
        }
    }
    
    @objc func getSearchCoordinatesButton() {
        guard let text = searchBar.text else { return }
        let map = MapViewController()
        getCoordinates(text, map.mapView) { result in
            guard let result = result else { return }
            self.delegate?.createSearchPin(coordinate: result)
            self.dismiss(animated: true)
        }
    }
//    var result = CLLocationCoordinate2D()
    
    func getCoordinates(_ adress: String?, _ mapView: MKMapView, completion: @escaping (CLLocationCoordinate2D?) -> Void) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = adress
        request.region = mapView.region
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            guard let response = response else {
				completion(nil)
				return
			}
            if let item = response.mapItems.first {
                if let location = item.placemark.location {
					completion(CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude))
                }
            }
            
        }
    }

}
