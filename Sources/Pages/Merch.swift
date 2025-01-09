//
//  Merch.swift
//
//
//  Created by Justin Purnell on 1/9/25.
//

import Foundation
import Ignite

struct Merch: StaticPage {
	var title = "Merch"
	var description: String = "A redirect page to the Class of 2000 Merch page"
	var image: String? = "/images/logos/P2000_25th_Lounging_Tiger.svg"

	func body(context: PublishingContext) -> [BlockElement] {
		var apparel: [Apparel] {
			let decoder = JSONDecoder()
			let data = try! Data(contentsOf: URL(fileURLWithPath: "/Users/jpurnell/Dropbox/Computer/Development/Swift/Princeton/Website/ExampleSite/Resources/apparel.json"))
			let apparelItems = try! decoder.decode([Apparel].self, from: data)
			return apparelItems.sorted(by: {$0.priority < $1.priority})
		}
		Section {
			for item in apparel {
				apparelCard(item)
			}
		}
		.margin()
		.columns(3)
	}
}
