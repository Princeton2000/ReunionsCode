
	//
	//  Committee.swift
	//  IgniteStarter
	//
	//  Created by Justin Purnell on 10/15/24.
	//

import Foundation

struct CrewMember: Codable, Comparable {
	static func < (lhs: CrewMember, rhs: CrewMember) -> Bool {
		if lhs.priority != rhs.priority {
			return lhs.priority < rhs.priority
		} else if lhs.year != rhs.year {
			return lhs.year < rhs.year
		} else {
			return lhs.lastName < rhs.lastName
		}
	}
	
	let firstName: String
	let lastName: String
	let role: String
	let year: Int
	let priority: Int
	let photo: String
	let email: String
	let summary: String
	var description: String { "\(firstName)  \(lastName) '\(year % 2000)" }
}
