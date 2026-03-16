//
//  Housing.swift
//  Princeton2000
//
//  Migrated to new Ignite API
//

import Foundation
import Ignite

struct Housing: StaticPage {
    @Environment(\.articles) var articles

    var title = "Housing"
    var description: String = "Housing options and FAQ for Princeton Class of 2000 Reunions, including on-campus rooms, off-campus alternatives, and booking details."
    var image: URL? = URL(string: "/images/logos/P2000_25th_Lounging_Tiger.svg")

    var housingArticles: [Article] {
        articles.typed("faq")
            .filter { ($0.tags ?? []).contains("housing") }
            .sorted(by: { ($0.tags?.first ?? "") < ($1.tags?.first ?? "") })
    }

    var body: some HTML {
        Accordion {
            for content in housingArticles {
                Item(content.metadata["question"] as? String ?? content.title) {
                    Text(markdown: content.text)
                }
            }
        }
    }
}
