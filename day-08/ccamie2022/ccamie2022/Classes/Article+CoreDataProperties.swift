//
//  Article+CoreDataProperties.swift
//  Pods
//
//  Created by Anton Ivanov on 22.08.2022.
//
//

import Foundation
import CoreData


extension Article {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Article> {
        return NSFetchRequest<Article>(entityName: "Article")
    }

    @NSManaged public var title: String?
    @NSManaged public var content: String?
    @NSManaged public var language: String?
    @NSManaged public var image: String?
    @NSManaged public var creationDate: Date?
    @NSManaged public var modificationDate: Date?

	public override var description: String {
		return  """
				Title             : \(String(describing: self.title))
				Content           : \(String(describing: self.content))
				Language          : \(String(describing: self.language))
				Image             : \(String(describing: self.image))
				Creation Date     : \(String(describing: self.creationDate))
				Modification Date : \(String(describing: self.modificationDate))
				"""
	}


}

