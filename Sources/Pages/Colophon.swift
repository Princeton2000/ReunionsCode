//
//  Colophon.swift
//  Princeton2000
//
//  Migrated to new Ignite API
//

import Foundation
import Ignite

struct Colophon: StaticPage {
    @Environment(\.articles) var articles

    var title = "Colophon"
    var description: String = "How our site is built."
    var image: URL? = URL(string: "/images/logos/P2000_25th_Lounging_Tiger.svg")

    var colophonArticles: [Article] {
        articles.typed("colophon")
    }

    var body: some HTML {
        Text(title).font(.title1)

        for content in colophonArticles {
            Text(content.text)
        }

        Text {
            "Created with "
            Link("Ignite", target: "https://github.com/twostraws/Ignite")
        }
        .horizontalAlignment(.center)
        .margin(.top, 50)
    }
}
