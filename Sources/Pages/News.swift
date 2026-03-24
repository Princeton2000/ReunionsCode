//
//  News.swift
//  Princeton2000
//
//  Migrated to new Ignite API
//

import Foundation
import Ignite

struct News: StaticPage {
    @Environment(\.articles) var articles

    var title = "News"
    var description = "Stay up to date with the latest news, achievements, and stories about Princeton Class of 2000 classmates and alumni activities."

    var body: some HTML {
        Text(title).font(.title1).class("visually-hidden")
        Section {
            for content in articles.typed("news") {
                Card {
                    if let image = content.image {
                        Image(image, description: content.imageDescription)
                            .resizable()
                            .cornerRadius(5)
                            .horizontalAlignment(.center)
                    }
                } header: {
                    if let link = content.metadata["link"] as? String, !link.isEmpty {
                        Link(content.metadata["title"] as? String ?? content.title, target: link)
                            .target(.newWindow)
                            .relationship(.noOpener, .noReferrer)
                    } else {
                        Text(content.metadata["title"] as? String ?? content.title)
                            .fontWeight(.semibold)
                    }
                }
                .width(3)
                .margin(.bottom)
                .padding(.horizontal, 5)
            }
        }
    }
}
