//
//  File.swift
//  IgniteStarter
//
//  Created by Justin Purnell on 8/5/24.
//

import Foundation

public struct SocialLink {
	let site: String
	let logoImage: String
	let link: String
	var fullLink: String { return "/images/social/\(logoImage).svg"}
}

public let socialLinkList: [SocialLink] = [
//	SocialLink(site: "WhatsApp", logoImage: "whatsapp", link: "https://chat.whatsapp.com/LmxLL6m77Ae2tKRConATC2"),
	SocialLink(site: "Instagram", logoImage: "instagram", link: "https://www.instagram.com/princetonclassof2000/"),
	SocialLink(site: "Bluesky", logoImage: "bluesky", link: "https://bsky.app/profile/princeton2000.org"),
	SocialLink(site: "Mastodon", logoImage: "mastodon", link: "https://mastodon.social/@princeton2000"),	
	SocialLink(site: "Threads", logoImage: "threads", link: "https://www.threads.net/@princetonclassof2000"),
	SocialLink(site: "Facebook", logoImage: "facebook", link: "https://www.facebook.com/groups/409748576503353/"),
	SocialLink(site: "Twitter", logoImage: "twitter", link: "https://twitter.com/pton00")
]
