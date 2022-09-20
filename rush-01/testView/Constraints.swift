//
//  Constraints.swift
//  testView
//
//  Created by Dmitry Kaveshnikov on 25/8/22.
//

import Foundation
import UIKit

extension MapViewController {
    
    func setupMapConstraints() {
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leftAnchor.constraint(equalTo: view.leftAnchor),
            mapView.rightAnchor.constraint(equalTo: view.rightAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
    
            labelDirections.topAnchor.constraint(equalTo: mapView.safeAreaLayoutGuide.topAnchor, constant: 30),
            labelDirections.centerXAnchor.constraint(equalTo: mapView.centerXAnchor),
            labelDirections.heightAnchor.constraint(equalToConstant: 40),
            labelLocation.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2.5),
            
            segmentBar.bottomAnchor.constraint(equalTo: mapView.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            segmentBar.centerXAnchor.constraint(equalTo: mapView.centerXAnchor),
            
            locationButton.leadingAnchor.constraint(equalTo: segmentBar.trailingAnchor, constant: 10),
            locationButton.centerYAnchor.constraint(equalTo: segmentBar.centerYAnchor),
            locationButton.heightAnchor.constraint(equalTo: segmentBar.heightAnchor),
            locationButton.heightAnchor.constraint(equalTo: locationButton.widthAnchor),
            
            labelLocation.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -70),
            labelLocation.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            labelLocation.leftAnchor.constraint(equalTo: view.leftAnchor),
            labelLocation.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            button.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            button.bottomAnchor.constraint(equalTo: locationButton.topAnchor, constant: -20),
            button.heightAnchor.constraint(equalToConstant: 50),
            button.widthAnchor.constraint(equalTo: button.heightAnchor),
            
            buttonDelete.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            buttonDelete.bottomAnchor.constraint(equalTo: locationButton.topAnchor, constant: -20),
            buttonDelete.heightAnchor.constraint(equalToConstant: 50),
            buttonDelete.widthAnchor.constraint(equalTo: button.heightAnchor),
            
            searchButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            searchButton.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 150),
            searchButton.heightAnchor.constraint(equalToConstant: 50),
            searchButton.widthAnchor.constraint(equalTo: button.heightAnchor),
        ])
    }
}
