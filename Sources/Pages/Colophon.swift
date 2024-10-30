//
//  Colophon.swift
//
//
//  Created by Justin Purnell on 7/8/24.
//

import Foundation
import Ignite

struct Colophon: StaticPage {
	var title = "Colophon"

	func body(context: PublishingContext) -> [BlockElement] {
		Section {
			for content in context.content(ofType: ("colophon")) {
				Text(content.title).font(.title2)
				Text(content.body)
			}
		}.columns(.max)
		Text {
			"Created with "
			Link("Ignite", target: URL("https://github.com/twostraws/Ignite"))
		}
		.horizontalAlignment(.center)
		.margin(.top, .extraLarge)
	}
}
