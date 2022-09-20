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
	let descriptionOfDeath: String
	var dateOfDeath: Date

	init(name: String, descriptionOfDeath: String, dateOfDeath: Date) {
		self.name = name
		self.descriptionOfDeath = descriptionOfDeath
		self.dateOfDeath = dateOfDeath
	}

}

extension Note: CustomStringConvertible {

	var description: String {
		var description = ""

		description += "Name: \(name)\n"
		description += "Description of death: \(descriptionOfDeath)\n"
		description += "Date of death: \(dateOfDeath.formatted(date: .complete, time: .complete))\n"

		return description
	}

}

typealias Notes = [Note]

