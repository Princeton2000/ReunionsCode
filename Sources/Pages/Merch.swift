//
//  Merch.swift
//  Princeton2000
//
//  Migrated to new Ignite API
//

import Foundation
import Ignite

struct Merch: StaticPage {
    @Environment(\.decode) var decode

    var title = "Merch"
    var description: String = "A redirect page to the Class of 2000 Merch page"
    var image: URL? = URL(string: "/images/logos/P2000_25th_Lounging_Tiger.svg")

    var body: some HTML {
        Grid {
            if let apparel = decode("apparel.json", as: [Apparel].self)?.sorted(by: { $0.priority < $1.priority }) {
                for item in apparel {
                    apparelCard(item)
                }
            }
        }
        .columns(3)
        .margin()
    }
}
