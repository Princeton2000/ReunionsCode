//
//  SocialLinks.swift
//  Princeton2000
//
//  Social media links component migrated to new Ignite API
//

import Foundation
import Ignite

struct SocialLinks: HTML {
    var links: [SocialLink] = socialLinkList

    var body: some HTML {
        Text {
            for link in links {
                Link(
                    Image(link.fullLink, description: link.site)
                        .resizable()
                        .frame(width: 24, height: 24)
                        .opacity(0.74)
                        .padding(.horizontal, 3)
                        .margin(.trailing, 10),
                    target: link.link
                )
                .role(.secondary)
                .target(.newWindow)
                .relationship(.me)
            }
        }
        .foregroundStyle(.princetonOrange)
    }
}
