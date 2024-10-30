	//
	//  News 2.swift
	//  IgniteStarter
	//
	//  Created by Justin Purnell on 8/20/24.
	//


import Foundation
import Cocoa
import Ignite
import OSLog

struct Notes: StaticPage {
	var title = "Class Notes"
	func fomatter() -> DateFormatter {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd hh:mm"
		return dateFormatter
	}
	
	func body(context: PublishingContext) -> [BlockElement] {
		
		Section {
			for content in context.content(ofType: "notes").sorted(by: { $0.metadata["date"] as! Date > $1.metadata["date"] as! Date}) {
				Card {
					Group {
						if let videoID = content.metadata["vimeo"] as? String {
							if let videoIDInt = NumberFormatter().number(from: videoID)?.intValue {
								Embed(vimeoID: videoIDInt, title: content.title).aspectRatio(.r16x9)
							}
						} else if let youTubeID = content.metadata["youtube"] as? String {
							Embed(youTubeID: youTubeID, title: content.title).aspectRatio(.r16x9)
						} else if let genericURL = content.metadata["url"] as? String {
							Embed(title: content.title, url: genericURL).aspectRatio(.r16x9)
						} else if let image = content.image {
							Image(image, description: content.imageDescription)
								.resizable()
								.cornerRadius(5)
								.frame(maxHeight: 418)
								.horizontalAlignment(.center)
//								.style("object-fit: scale-down; object-position: center; height: 200px ;")
						}
					}
					Group {
						Spacer()
						Divider()
						Link(target: content.metadata["link"] as? String ?? "") {
							Text(content.metadata["title"] as! String)
								.font(.title4).fontWeight(.semibold).foregroundStyle(.princetonOrange)
						}
						
						.target(.newWindow)
						.relationship(.noOpener, .noReferrer)
					}
					.frame(height: 200)
				}
				.contentPosition(.overlay(alignment: .top))
				.frame(height: 520, minHeight: 256)
				.width(3)
				.margin(.bottom)
				.padding(.horizontal, 5)
			}
			
				//				header: {
				//					Link(target: content.metadata["link"] as? String ?? "") {
				//						Text(content.metadata["title"] as! String)
				//							.font(.title4).fontWeight(.semibold).foregroundStyle(.princetonOrange)
				//					}
				//					.target(.newWindow)
				//					.relationship(.noOpener, .noReferrer)
				//				}
				//				footer: {
				//					let tagLinks = content.tagLinks(in: context)
				//
				//					if tagLinks.isEmpty == false {
				//						Group {
				//							tagLinks
				//						}
				//						.style("margin-top: -5px")
				//					}
				//				}
			
		}
	}
}
