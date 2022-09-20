//
//  Note.swift
//  DeathNote
//
//  Created by Anton Ivanov on 12.08.2022.
//

import Foundation

// MARK: - Note
struct Note {

	let name: String
	let description: String
	var timeOfLastVisit: Date

	init(name: String, description: String) {
		self.name = name
		self.description = description
		timeOfLastVisit = Date()
	}

}

typealias Notes = [Note]

