//
//  ArticleManager.swift
//  Pods
//
//  Created by Anton Ivanov on 22.08.2022.
//

import Foundation
import CoreData


public typealias Articles = [Article]


public class ArticleManager: NSObject {

	private var manager: NSManagedObjectContext



	public override init() {
		guard let bundle = Bundle(identifier: "org.cocoapods.ccamie2022") else {
			fatalError("Error bundle")
		}

		guard let modelURL = bundle.url(
			forResource: "article",
			withExtension: "momd"
		) else {
			fatalError("Error model")
		}

		guard let mom = NSManagedObjectModel(contentsOf: modelURL) else {
			fatalError("Error model")
		}

		let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: mom)
		
		manager = NSManagedObjectContext(
			concurrencyType: NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType
		)
		manager.persistentStoreCoordinator = persistentStoreCoordinator

		let docURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last
		let storeURL = docURL?.appendingPathComponent("ccamie2022.sqlite")

		do {
			try persistentStoreCoordinator.addPersistentStore(
				ofType: NSSQLiteStoreType,
				configurationName: nil,
				at: storeURL,
				options: nil
			)
		} catch {
			fatalError("Error: \(error)")
		}

		super.init()
	}



	public func newArticle() -> Article {
		let article = Article(context: self.manager)

		return article
	}



	public func getAllArticles() -> Articles {
		var articles = Articles()
		let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Article")

		do {
			articles = try manager.fetch(request) as! Articles
		} catch let error {
			print("Error", error)
		}

		return articles
	}



	public func getArticles(withLang lang: String) -> Articles {
		var articles = Articles()
		let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Article")
		let predicate = NSPredicate(format: "language == %@", lang)

		request.predicate = predicate

		do {
			articles = try manager.fetch(request) as! Articles
		} catch let error {
			print("Error", error)
		}

		return articles
	}



	public func getArticles(containString str: String) -> Articles {
		var articles = Articles()
		let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Article")
		let predicate = NSPredicate(
			format: "content CONTAINS %@ || title CONTAINS %@",
			str.lowercased(),
			str.lowercased()
		)

		request.predicate = predicate

		do {
			articles = try manager.fetch(request) as! Articles
		} catch let error {
			print("Error", error)
		}

		return articles
	}



	public func removeArticle(article: Article) {
		manager.delete(article)
	}



	public func save() {
		if manager.hasChanges == false {
			return
		}

		do {
		   try manager.save()
	   } catch let error {
		   manager.rollback()
		   print ("Error", error)
	   }
	}


}

