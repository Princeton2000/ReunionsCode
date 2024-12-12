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
	var entries: [LibraryEntry] { let decoder = JSONDecoder()
		let data = try! Data(contentsOf: URL(fileURLWithPath: "/Users/jpurnell/Dropbox/Computer/Development/Swift/Princeton/Website/ExampleSite/Resources/library.json"))
//		let data = try! Data(contentsOf: URL("https://opensheet.elk.sh/1e6_opVycMzokNNTs-isEfa4xGHICsBYFlgkduFtFJz4/2"))
		let entries = try! decoder.decode([LibraryEntry].self, from: data)
		return entries.sorted(by: {$0.classmate < $1.classmate})
	}
	var classmates: [Classmate] { return Array(Set(entries.map { $0.classmate })).sorted(by: {$0.lastName < $1.lastName }) }
	
	func entriesByClassmate(_ classmate: Classmate) -> [LibraryEntry] {
		let classmateEntries = entries.filter({ $0.classmate == classmate })
		return classmateEntries.filter({ $0.title != nil }).sorted(by: {$0.date > $1.date })
	}
	
	func body(context: PublishingContext) -> [BlockElement] {
		Include("styleInjection.html")
		for classmate in classmates.filter({ entriesByClassmate($0).count > 0 }) {
			Text("\(classmate.description.replacingOccurrences(of: "\n", with: "<p>"))").padding([.leading, .vertical]).font(.title1).fontWeight(.semibold).background(.princetonOrange).padding(.vertical).id(classmate.description)
			Table {
				for (index, entry) in entriesByClassmate(classmate).enumerated() {
					entry.musicEntry ? libraryMusicRow(entry) : libraryRow(entry, includeDivider: index != entriesByClassmate(classmate).count - 1)
				}
			}
			.tableBorder(false)
			.padding(.horizontal)
		}
	}
}
