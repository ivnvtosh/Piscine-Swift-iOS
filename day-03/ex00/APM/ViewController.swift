//
//  ViewController.swift
//  APM
//
//  Created by Anton Ivanov on 13.08.2022.
//

import UIKit

// MARK: - Cell
struct Cell {

	let name: String

}

typealias Cells = [Cell]

class ViewController: UIViewController, UICollectionViewDelegate {

	var cells = [Cell(name: "image1"),
				 Cell(name: "image2"),
				 Cell(name: "image3"),
				 Cell(name: "image4"),
				 Cell(name: "image5"),
				 Cell(name: "image6"),
				]

	@IBOutlet weak var collectionView: UICollectionView!

	let cellId = "CollectionViewCellImage"

	override func viewDidLoad() {
		super.viewDidLoad()

		let nib = UINib(nibName: cellId, bundle: nil)
		collectionView.register(nib, forCellWithReuseIdentifier: cellId)
		collectionView.dataSource = self
//		collectionView.delegate = self
	}


}

extension ViewController: UICollectionViewDataSource {

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return cells.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? CollectionViewCellImage

//		if cell == nil {
//			cell = CollectionViewCellImage()
//		}

		cell?.image.image = UIImage(named: cells[indexPath.row].name)
		return cell!
	}

}
//
//extension ViewController: UICollectionViewDelegate {
//
//}
