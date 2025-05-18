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
		Alert {
			Text(markdown: "The store is currently **closed** while we transition to a new infrastrucure ahead of Reunions. Browse though – you will be able to buy all of this whe you get to campus and afterwards on our brand new store.").fontWeight(.semibold).horizontalAlignment(.center)
		}.role(.info)
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
