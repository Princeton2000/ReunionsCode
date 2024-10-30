//
//  Story.swift
//  
//
//  Created by Justin Purnell on 7/8/24.
//

import Foundation
import Ignite

struct Email: ContentPage {	
	
	func body(content: Content, context: PublishingContext) -> [any BlockElement] {
		Group {
			Text(content.metadata["title"] as? String ?? "\(content.title)")
				.font(.title4)
			Text(formatDate(content.metadata["lastModified"] as? String ?? "", .medium, .short))

			if let image = content.image {
				Image(image, description: content.imageDescription)
					.resizable()
					.cornerRadius(10)
					.horizontalAlignment(.center)
			}
			Text(content.body)
		}
		.frame(maxWidth: 900)
		.padding(.horizontal, 5)
	}
}
