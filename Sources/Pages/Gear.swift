//
//  Gear.swift
//  Princeton2000
//
//  Migrated to new Ignite API
//

import Foundation
import Ignite

struct Gear: StaticPage {
    @Environment(\.decode) var decode

    var title = "Class Gear"
    var description: String = "Browse and purchase official Princeton Class of 2000 apparel and accessories, with size charts and ordering information."
    var image: URL? = URL(string: "/images/logos/P2000_25th_Lounging_Tiger.svg")

    var body: some HTML {
        Alert {
            Text(markdown: "The store is currently **closed** while we transition to a new infrastrucure. Browse though – you will be able to buy all of this whe you get to campus and afterwards on our brand new store.")
                .fontWeight(.semibold)
                .horizontalAlignment(.center)
        }
        .role(.info)

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
