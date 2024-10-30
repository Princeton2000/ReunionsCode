//
//  Dues.swift
//
//
//  Created by Justin Purnell on 7/8/24.
//

import Foundation
import Ignite

struct Gear: StaticPage {
	var title = "Class Gear"

	func body(context: PublishingContext) -> [BlockElement] {
		var merchandise: [Merch] { let decoder = JSONDecoder(); let data = try! Data(contentsOf: URL(fileURLWithPath: "/Users/jpurnell/Dropbox/Computer/Development/Swift/Princeton/Website/ExampleSite/Resources/merch.json")); let merch = try! decoder.decode([Merch].self, from: data); return merch.sorted(by: {$0.priority < $1.priority})}
		Section {
			for item in merchandise {
				merchCard(item)
			}
		}
		.margin()
		.columns(3)
	}
}
