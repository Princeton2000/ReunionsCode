//
//  LibraryEntry.swift
//  IgniteStarter
//
//  Created by Justin Purnell on 9/3/24.
//

import Foundation

struct LibraryEntry: Codable {
	let classmate: Classmate
	let image: String?
	let title: String?
	let description: String?
	let links: [LibraryLink]
	var dateString: String
	var date: Date { let dateFormatter = DateFormatter(); dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"; let date = dateFormatter.date(from: dateString)!; /*print("Got Date \(date) for \(title ?? "") with \(dateString)");*/ return date }
	var musicEntry: Bool { links.contains(where: {$0.source == .appleMusic && $0.url != nil || $0.source == .spotify && $0.url != nil  }) }
}
