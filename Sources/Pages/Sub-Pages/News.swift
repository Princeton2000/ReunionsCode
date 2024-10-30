//
//  Housing.swift
//
//
//  Created by Justin Purnell on 7/8/24.
//

import Foundation
import Cocoa
import Ignite

struct News: StaticPage {
	var title = "News"
	
	func body(context: PublishingContext) -> [BlockElement] {
		Section {
			for content in context.content(ofType: ("news"))
//				.filter({$0.metadata["published"] as? String == "true"})
			{
				Card {
					if let image = content.image {
						Image(image, description: content.imageDescription)
							.resizable()
							.cornerRadius(5)
							.horizontalAlignment(.center)
					}
				} header: {
					Link(target: content.metadata["link"] as? String ?? "") {
						Text(content.metadata["title"] as! String)
							.font(.title4).fontWeight(.medium)
					}
					.target(.newWindow)
					.relationship(.noOpener, .noReferrer)
				}
				.width(3)
				.margin(.bottom)
				.padding(.horizontal, 5)
			}
		}
	}
}
