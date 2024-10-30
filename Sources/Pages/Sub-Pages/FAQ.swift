//
//  Housing.swift
//
//
//  Created by Justin Purnell on 7/8/24.
//

import Foundation
import Ignite

struct faq: StaticPage {
	var title = "faq"

	func body(context: PublishingContext) -> [BlockElement] {
		Accordion {
			for content in context.content(ofType: "faq").filter({$0.tags[0] != "template"}).sorted(by: {$0.tags[0] < $1.tags[0]}) {
				Item(content.metadata["question"] as! InlineElement) {
					Text(markdown: content.body)
					if content.hasTags {
							Text {
								content.tagLinks(in: context)
							}.font(.title6)
					}

				}
			}
		}
	}
}
