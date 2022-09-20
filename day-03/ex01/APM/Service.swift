//
//  Service.swift
//  APM
//
//  Created by Anton Ivanov on 13.08.2022.
//

import UIKit

// MARK: - Manager
class Manager {

	static let shared = Manager()

	func loadImage(with url: URL?, completion: @escaping (UIImage?) -> Void) {
		guard let url = url else {
			print("Invalid URL")
			return
		}

		URLSession.shared.dataTask(with: url) { data, response, error in
			if let error = error {
				print(error)
				completion(nil)
			}

			guard let data = data else {
				print("No data available")
				completion(nil)
				return
			}

			let image = UIImage(data: data)
			completion(image)

		}.resume()
	}

}

