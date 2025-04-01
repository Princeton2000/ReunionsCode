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
		Text {
			Link("The Locomotive", target: "https://princetoniana.princeton.edu/traditions/current/cheers")
		}
		Text {
			Link("The P-Rade", target: "https://alumni.princeton.edu/stories/reunions-history-princeton-p-rade")
		}
		
		Include("appleMusicEmbed.html")
	}
}
