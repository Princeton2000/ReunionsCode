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
	var description: String = "Learn about our theme: Bid Every Care Withdraw"
	var image: String? = "/images/logos/P2000_25th_Lounging_Tiger.svg"
	
	let jacketUpdateImages = (1...22).map({"/images/jacket/testSlides/testSlide.\(String(format: "%03d", $0)).png"})
	
	func body(context: PublishingContext) -> [BlockElement] {
		Section {
			Spacer()
//			Image("/images/logos/P2000_25th_TigerHead_BECW.svg", description: "The Bid Every Care Withdraw Logo")
//			Image("/images/logos/P2000_25th_TigerHead.svg", description: "The Bid Every Care Withdraw Logo")
			Image("/images/logos/P2000_25th_Lounging_Tiger.svg", description: "The Bid Every Care Withdraw Logo")
			
				.resizable()
				.frame(width: 600)
			Spacer()
				
		}
		.horizontalAlignment(.center)
		Spacer()
		Section {
			Text("Bid Every Care Withdraw").class("tayLennon").font(.title1).foregroundStyle(.princetonOrange)
		}.horizontalAlignment(.center)
		Divider()
		Text("Our Theme").class("tayLennon").font(.title1).padding([.leading])
		for content in context.content(ofType: "theme") {
			Text(content.body).padding([.leading, .trailing])
		}
//		Embed(youTubeID: "eWJmDZv6RIQ", title: "'00ld Nassau").aspectRatio(.r16x9)
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

