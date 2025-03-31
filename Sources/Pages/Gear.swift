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
		Section {
			if let apparel = context.decode(resource: "apparel.json", as: [Apparel].self)?.sorted(by: { $0.priority < $1.priority }) {
				for item in apparel {
					apparelCard(item)
				}
			}
		}
		.margin()
		.columns(3)
	}
}
