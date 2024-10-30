//
//  Housing.swift
//
//
//  Created by Justin Purnell on 7/8/24.
//

import Foundation
import Ignite

struct Prade: StaticPage {
	var title = "The one and only P-rade"

	func body(context: PublishingContext) -> [BlockElement] {
		for content in context.content(ofType: "p-rade") {
			Text(content.body)
		}
		
		Include("appleMusicEmbed.html")
	}
}
