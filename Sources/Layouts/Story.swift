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
		Text {
			Link(target: content.metadata["link"] as? String ?? "#") {
				Text(content.metadata["question"] as? String ?? "\(content.metadata["title"] ?? "")")
					.font(.title1)
			}
		}

		if let image = content.image {
			Image(image, description: content.imageDescription)
				.resizable()
				.cornerRadius(20)
				.frame(maxHeight: 300)
				.horizontalAlignment(.center)
		}

		if content.hasTags {
			Group {
//				Text("\(content.estimatedWordCount) words; \(content.estimatedReadingMinutes) minutes to read.")
				if content.hasTags {
						Text {
							content.tagLinks(in: context)
						}.font(.title6)
				}
			}
		}

		Text(content.body)
		if content.metadata["link"] as? String != nil {
			Text {
				Link(target: content.metadata["link"] as? String ?? "#") {
					"Read more..."
				}
			}
		}
	}
}
