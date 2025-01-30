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
							Image(image, description: content.description).accessibilityLabel(content.tags.filter({$0 != "Class Notes"}).joined(separator: ", "))
								.resizable()
						}
					}
					.addCustomAttribute(name: "style", value: "border-radius: 5px; width: 100%; height: 60%; max-height: 418px; object-fit: cover; object-position: 100% 56%;")
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
					.frame(height: "25%")
				}
				.contentPosition(.top)
				.frame(height: "97.5%")
				.width(3)
				.margin(.bottom)
				.padding(.horizontal, 5)
			}
		}
	}
}
