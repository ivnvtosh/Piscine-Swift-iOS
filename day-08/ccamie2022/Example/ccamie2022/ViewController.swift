//
//  ViewController.swift
//  ccamie2022
//
//  Created by 87498837 on 08/22/2022.
//  Copyright (c) 2022 87498837. All rights reserved.
//

import UIKit
import ccamie2022

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

		self.view.backgroundColor = .red

		let articleManager = ArticleManager()
		let article = articleManager.newArticle()
		article.title = "LOl"
		article.language = "en"
//		articleManager.save()

		print(articleManager.getArticles(withLang: "en"))
		for article in articleManager.getAllArticles() {
//			articleManager.removeArticle(article: article)
//		 	print(article)
		}
//		articleManager.save()
		print(articleManager.getAllArticles().count)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

