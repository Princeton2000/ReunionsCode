//
//  Committee.swift
//  IgniteStarter
//
//  Created by Justin Purnell on 10/15/24.
//

import Foundation

struct CommitteeMember: Codable {
	let firstName: String
	let lastName: String
	let chair: String
	let role: String
	let photo: String
	let email: String
	let priority: Int
	var name: String { "\(firstName) \(lastName)"}
}
