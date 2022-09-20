//
//  ScrollViewImageLol.swift
//  APM
//
//  Created by Anton Ivanov on 14.08.2022.
//

import UIKit

class ScrollViewImageLol: UIScrollView {

	var imageView: UIImageView!

	override init(frame: CGRect) {
		super.init(frame: frame)

		self.delegate = self
		self.showsVerticalScrollIndicator = false
		self.showsHorizontalScrollIndicator = false
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func set(image: UIImage) {
		imageView?.removeFromSuperview()
		imageView = nil

		imageView = UIImageView(image: image)
		self.addSubview(imageView)

		configurateFor(imageSize: image.size)
	}

	func configurateFor(imageSize: CGSize) {
		self.contentSize = imageSize

		setCurrentMaxAndMinScale()
		self.zoomScale = self.minimumZoomScale
	}

	func setCurrentMaxAndMinScale() {
		let boundsSize = self.bounds.size
		let imageSize = self.imageView.bounds.size

		let x = boundsSize.width / imageSize.width
		let y = boundsSize.height / imageSize.height

		let min = min(x, y)

		self.minimumZoomScale = min
		self.maximumZoomScale = 1.5
	}

	override func layoutSubviews() {
		super.layoutSubviews()

		self.centerImage()
	}

	func centerImage() {
		let boundsSize = self.bounds.size
		var frameToCenter = imageView.frame

		if frameToCenter.size.width < boundsSize.width {
			frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width) / 2
		} else {
			frameToCenter.origin.x = 0
		}

		if frameToCenter.size.height < boundsSize.height {
			frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height) / 2
		} else {
			frameToCenter.origin.y = 0
		}

		imageView.frame = frameToCenter
	}

}

extension ScrollViewImageLol: UIScrollViewDelegate {

	func viewForZooming(in scrollView: UIScrollView) -> UIView? {
		return self.imageView
	}

	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		self.centerImage()
	}
}
