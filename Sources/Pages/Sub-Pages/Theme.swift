//
//  Housing.swift
//
//
//  Created by Justin Purnell on 7/8/24.
//

import Foundation
import Ignite

struct BidEveryCareWithdraw: StaticPage {
	var title = "Bid Every Care Withdraw"
	let jacketUpdateImages = (1...22).map({"/images/jacket/testSlides/testSlide.\(String(format: "%03d", $0)).png"})
	
	func body(context: PublishingContext) -> [BlockElement] {
		Embed(youTubeID: "eWJmDZv6RIQ", title: "'00ld Nassau").aspectRatio(.r16x9)
		Section {
//			Carousel {
//				for image in jacketTestSlides {
//					Slide(background: image)
//				}
//			}.carouselStyle(.move)
		}.columns(8).horizontalAlignment(.center)
		
//		Divider()
		Accordion {
			for content in context.content(ofType: "faq").filter({$0.tags.contains("theme")}).sorted(by: {$0.tags[0] < $1.tags[0]}) {
				Item(content.metadata["question"] as! InlineElement) {
					Text(markdown: content.body)
				}
			}
		}
	}
}

