//
//  File.swift
//  
//
//  Created by Justin Purnell on 7/18/24.
//

import Foundation
import Ignite

struct Tags: TagPage {
	func body(tag: String?, context: PublishingContext) async -> [any BlockElement] {
		if let tag {
			Text(tag)
				.font(.title1)
		} else {
			Text("All tags")
				.font(.title1)
		}
		
		let articles = context.content(tagged: tag)
		
		List {
			for article in articles {
				Text {
					Link((article.metadata["question"] ?? article.metadata["title"]) as! String, target: article.path)
				}
			}
		}
	}
}
