//
//  ViewControllerImage.swift
//  APM
//
//  Created by Anton Ivanov on 14.08.2022.
//

import UIKit

class ViewControllerImageLol: UIViewController {

	var scrollViewImage: ScrollViewImageLol!

	var	image: UIImage?

	override func viewDidLoad() {
        super.viewDidLoad()

		scrollViewImage = ScrollViewImageLol(frame: view.bounds)
		view.addSubview(scrollViewImage)
		setupScrollViewImage()

		if let image = image {
			self.scrollViewImage.set(image: image)
		} else {
			self.scrollViewImage.set(image: UIImage(systemName: "exclamationmark.icloud")!)
		}

    }

	func setupScrollViewImage() {
		scrollViewImage.translatesAutoresizingMaskIntoConstraints = false
		
		scrollViewImage.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		scrollViewImage.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
		scrollViewImage.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		scrollViewImage.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
	}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
