
	//
	//  Committee.swift
	//  IgniteStarter
	//
	//  Created by Justin Purnell on 10/15/24.
	//

import Foundation

struct HonoraryClassmate: Codable, Comparable {
	static func < (lhs: HonoraryClassmate, rhs: HonoraryClassmate) -> Bool {
		if lhs.priority != rhs.priority {
			return lhs.priority < rhs.priority
		} /*else if lhs.year != rhs.year {
			return lhs.year ?? 0 < rhs.year ?? 0
		}*/ else {
			return lhs.lastName < rhs.lastName
		}
	}
	
	let firstName: String
	let lastName: String
	let role: String
	let year: Int?
	let priority: Int
	let photo: String
	let email: String
	let summary: String
	var description: String { "\(firstName) \(lastName)" }
}
