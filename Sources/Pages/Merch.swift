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
    var description: String = "Shop official Princeton Class of 2000 merchandise — hats, shirts, accessories, and more to show your Tiger pride."
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
