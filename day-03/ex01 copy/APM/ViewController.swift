//
//  ViewController.swift
//  APM
//
//  Created by Anton Ivanov on 13.08.2022.
//

import UIKit

struct CellIm {

	let url: URL?
	let image: UIImage?

	init(url: URL?) {
		self.url = url
	}

	func set(image: UIImage) {
		
	}

}

typealias CellsIm = CellIm

class ViewController: UIViewController, UICollectionViewDelegate {

	var urls = [URL(string: "https://img1.akspic.ru/crops/6/8/4/9/6/169486/169486-apple_masvook_pro-kompyuter_imac-operacionnaya_sistema-yabloko-atmosfera-3840x216"),
				URL(string: "https://img1.akspic.ru/crops/6/8/4/9/6/169486/169486-apple_masvook_pro-kompyuter_imac-operacionnaya_sistema-yabloko-atmosfera-3840x2160.jpg"),
				URL(string: "https://img3.akspic.ru/crops/4/8/3/9/6/169384/169384-vashe_imya-miyamizu_mitsuha-anime-taki_tachibana-atmosfera-3840x2160.png"),
				URL(string: "https://img3.akspic.ru/crops/9/9/3/9/6/169399/169399-kauai-oblako-rastenie-legkovyye_avtomobili-gora-3840x2160.jpg"),
				URL(string: "https://img2.akspic.ru/crops/4/8/2/9/6/169284/169284-purge_mask-svetodiodnaya_maska-bal_maskarad-feshn-vecherinka-3840x2160.jpg"),
				URL(string: "https://img3.akspic.ru/crops/6/5/8/8/6/168856/168856-luchshij_slon-afrikanskij_bujvol-lev-nosorog-chernyj_nosorog-3840x2160.jpg"),
				URL(string: "https://img1.akspic.ru/crops/5/5/8/8/6/168855/168855-gorod-ieroglif-most-neboskreb-zdanie-3840x2160.jpg"),
				URL(string: "https://img3.akspic.ru/crops/9/3/1/9/6/169139/169139-relaksaciya_priroda-kit_poet_melodiyu_chtoby_zasnut-oblako-gora-ekoregion-3840x2160.jpg"),
				URL(string: "https://img3.akspic.ru/crops/1/5/5/8/6/168551/168551-rozhdestvenskie_ogni-girlyanda-ulichnyj_fonar-ukrashenie-ornament-3840x2160.jpg"),
				URL(string: "https://img3.akspic.ru/crops/7/4/8/8/6/168847/168847-anime-anime_devushka-anime_art-multfilm-druzya_anime_braziliya-3840x2160.jpg"),
				URL(string: "https://img1.akspic.ru/crops/1/5/8/8/6/168851/168851-nyujork-medison_skver_park-fletajron_bilding-centralnyj_park-yunion_skver-3840x2160.jpg"),
				URL(string: "https://img2.akspic.ru/crops/8/5/6/8/6/168658/168658-fraktalnoe_iskusstvo-art-risovanie-purpur-naturalnyj_material-3840x2160.jpg"),
				URL(string: "https://img3.akspic.ru/crops/4/8/1/8/6/168184/168184-nacionalnyj_park_kaziranga-nacionalnyj_park_banf-josemiti-nacionalnyj_park-nacionalnyj_park_zajon-3840x2160.jpg"),
				URL(string:  "https://img2.akspic.ru/crops/8/0/1/9/6/169108/169108-voda-purpur-fioletovyj-rozovyj-art-3840x2160.jpg"),
				URL(string: "https://img2.akspic.ru/crops/1/1/3/8/6/168311/168311-niderlandy-osen-tablica-derevo-rastenie-3840x2160.jpg"),
				URL(string: "https://img2.akspic.ru/crops/5/5/9/7/6/167955/167955-gora-oblako-atmosfera-ekoregion-priroda-3840x2160.jpg"),
				URL(string: "https://img2.akspic.ru/crops/6/1/9/7/6/167916/167916-tysyacha_solnechnyh-odin_kusok-sobiraetsya_zhenitsya-atmosfera-priroda-3840x2160.jpg"),
				URL(string: "https://img2.akspic.ru/crops/7/1/9/7/6/167917/167917-nagi_no_asukara-art-voda-atmosfera-sinij-3840x2160.jpg"),
				URL(string: "https://img3.akspic.ru/crops/2/6/5/9/6/169562/169562-list-nauka-krasochnost-art-materialnoe_svojstvo-3840x2160.png"),
				URL(string: "https://img3.akspic.ru/crops/1/8/7/8/6/168781/168781-rasteniya_zhivotnye-olen-evropejskaya_lan-kosulya-olenij_rog-3840x2160.jpg"),
				URL(string: "https://img3.akspic.ru/crops/0/1/6/8/6/168610/168610-macos_13_official_stock_wallpaper_dark-3840x2160.jpg"),
				URL(string: "https://img2.akspic.ru/crops/4/0/6/8/6/168604/168604-plamya-ogon-ulichnyj_fonar-gaz-teplo-3840x2160.jpg"),
				
		]

	@IBOutlet weak var collectionView: UICollectionView!

	let cellId = "CollectionViewCellImage"

	override func viewDidLoad() {
		super.viewDidLoad()

		let nib = UINib(nibName: cellId, bundle: nil)
		collectionView.register(nib, forCellWithReuseIdentifier: cellId)
		collectionView.dataSource = self
		collectionView.delegate = self

	}


}

extension ViewController: UICollectionViewDataSource {

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return urls.count
//		return 4
	}

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCellImage

		let controller = self.storyboard?.instantiateViewController(withIdentifier: "ViewControllerImageLol") as! ViewControllerImageLol

		controller.image = cell.imageView.image
		self.navigationController?.pushViewController(controller, animated: true)

	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CollectionViewCellImage

		let url = urls[indexPath.item]

		Manager.shared.loadImage(with: url) { image in
			guard let image = image else {
				DispatchQueue.main.async {
					cell.imageView.backgroundColor = .systemGray6
					cell.activityIndicator.stopAnimating()
					cell.activityIndicator.isHidden = true
					cell.imageView.isHidden = false

					let controller = self.storyboard?.instantiateViewController(withIdentifier: "ViewControllerErrorMessage") as! ViewControllerErrorMessage
					controller.descriptionText = "Cannot acces to \(url!)"
					self.present(controller, animated: true, completion: nil)
				}

				return
			}

			DispatchQueue.main.async {
				cell.imageView.image = image
				cell.activityIndicator.stopAnimating()
				cell.activityIndicator.isHidden = true
				cell.imageView.isHidden = false
			}
		}

		return cell
	}

}

//extension ViewController: UICollectionViewDelegateFlowLayout {
//
//	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//		return 12
//	}
//
//	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//		return 12
//	}
//
//}

//extension ViewController: UICollectionViewDelegate {
//
//}
