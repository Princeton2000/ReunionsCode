//
//  Library.swift
//  IgniteStarter
//
//  Created by Justin Purnell on 9/3/24.
//

import Foundation
import Ignite

//TODO: Group by Author
//TODO: Build Image-based social links
//TODO: Set default image per link
//TODO: Add Social Links

struct Library: StaticPage {
	var title = "Library"
	
	func entriesByClassmate(_ classmate: Classmate, from entries: [LibraryEntry]) -> [LibraryEntry] {
		let classmateEntries = entries.filter({ $0.classmate == classmate })
		return classmateEntries.filter({ $0.title != nil }).sorted(by: {$0.date > $1.date })
	}
	
	func body(context: PublishingContext) -> [BlockElement] {
		Include("styleInjection.html")
		if let entries = context.decode(resource: "library.json", as: [LibraryEntry].self) {
			var classmates: [Classmate] { return Array(Set(entries.map { $0.classmate })).sorted(by: {$0.lastName < $1.lastName }) }
			
			for classmate in classmates.filter({ entriesByClassmate($0, from: entries).count > 0 }) {
				Text("\(classmate.description.replacingOccurrences(of: "\n", with: "<p>"))").padding([.leading, .vertical]).font(.title1).fontWeight(.semibold).background(.princetonOrange).padding(.vertical).id(classmate.description)
				Table {
					for (index, entry) in entriesByClassmate(classmate, from: entries).enumerated() {
						entry.musicEntry ? libraryMusicRow(entry) : libraryRow(entry, includeDivider: index != entriesByClassmate(classmate, from: entries).count - 1)
					}
				}
				.tableBorder(false)
				.padding(.horizontal)
			}
		}
	}
}
