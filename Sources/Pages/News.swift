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

    var body: some HTML {
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
                    Link(content.metadata["title"] as? String ?? content.title, target: content.metadata["link"] as? String ?? "")
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
