//
//  Dues.swift
//
//
//  Created by Justin Purnell on 7/8/24.
//

import Foundation
import Ignite

struct Dues: StaticPage {
	var title = "Class Dues"
	var description: String = "Pay your dues…we need them!!"
	var image: String? = "/images/logos/P2000_25th_Lounging_Tiger.svg"

	func body(context: PublishingContext) -> [BlockElement] {
		Group {
			Text("Dues").font(.title1).fontWeight(.semibold)
			for content in context.content(ofType: "dues") {
				Text(content.body)
			}
		}.padding(.horizontal, 20)
	}
}
