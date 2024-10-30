//
//  File.swift
//  IgniteStarter
//
//  Created by Justin Purnell on 9/3/24.
//

import Foundation

struct Classmate: Codable, Comparable, Hashable {
	static func < (lhs: Classmate, rhs: Classmate) -> Bool {
		return lhs.lastName < rhs.lastName && lhs.firstName < rhs.firstName
	}
	
	let firstName: String
	let lastName: String
	var description: String { return "\(firstName) \(lastName)"}
}
