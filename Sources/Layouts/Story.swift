//
//  Story.swift
//  
//
//  Created by Justin Purnell on 7/8/24.
//

import Foundation
import Ignite

struct Story: ContentPage {
	func body(content: Content, context: PublishingContext) -> [any BlockElement] {
		Text(content.metadata["title"] as? String ?? "\(content.title)")
			.font(.title2)

		if let image = content.image {
			Image(image, description: content.imageDescription)
				.resizable()
				.cornerRadius(20)
				.frame(maxHeight: 300)
				.horizontalAlignment(.center)
		}

		if content.hasTags {
			Group {
				Text("Tagged with: \(content.tags.joined(separator: ", "))")

				Text("\(content.estimatedWordCount) words; \(content.estimatedReadingMinutes) minutes to read.")
			}
		}

		Text(content.body)
	}
}
