//
//  File.swift
//  IgniteStarter
//
//  Created by Justin Purnell on 8/5/24.
//

import Foundation
import Ignite

public struct SocialLinks: Component {
	var links: [SocialLink] = socialLinkList
	
	public func body(context: PublishingContext) -> [any PageElement] {
		Text {
			for link in links {
				Link(
					Image(link.fullLink, description: link.site)
						.frame(width: 24)
						.resizable()
						.opacity(0.74)
						.foregroundStyle(.secondary)
//					.frame(width: 30, height: 30)
					.padding(.horizontal, "3px")
					.margin(.trailing, "10px"), target: link.link)
				.role(.secondary)
				.target(.newWindow)
				.relationship(.noOpener, .noReferrer)
			}
		}.foregroundStyle(.princetonOrange)
	}
	
	public init() {}
	
}
