//
//  CollectionViewCellImage.swift
//  APM
//
//  Created by Anton Ivanov on 13.08.2022.
//

import UIKit

class CollectionViewCellImage: UICollectionViewCell {

	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var activityIndicator: UIActivityIndicatorView!

	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

