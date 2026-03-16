//
//  Prade.swift
//  Princeton2000
//
//  Migrated to new Ignite API
//

import Foundation
import Ignite

struct Prade: StaticPage {
    @Environment(\.articles) var articles

    var title = "The one and only P-rade"
    var description = "Everything you need to know about the P-rade at Princeton Reunions."

    var body: some HTML {
        for content in articles.typed("p-rade") {
            Text(content.text)
        }

        Text {
            Link("The Locomotive", target: "https://princetoniana.princeton.edu/traditions/current/cheers")
        }

        Text {
            Link("The P-Rade", target: "https://alumni.princeton.edu/stories/reunions-history-princeton-p-rade")
        }

        Include("appleMusicEmbed.html")
    }
}
