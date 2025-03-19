//
//  Housing.swift
//
//
//  Created by Justin Purnell on 7/8/24.
//

import Foundation
import Ignite

struct Constitution: StaticPage {
	var title = "Class Constitution"

	func body(context: PublishingContext) -> [BlockElement] {
		Text {
			Link("Class Constitution", target: "/constitution/constitution.pdf")
										.target(.newWindow)
										.relationship(.noOpener, .noReferrer)
		}.font(.title5).fontWeight(.semibold).horizontalAlignment(.center)
		Include("constitution.html")
		
	}
}
