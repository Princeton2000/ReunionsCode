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
	var description: String = "Size Charts and links to purchase Class of 2000 Gear"
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
