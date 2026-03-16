//
//  Dues.swift
//  Princeton2000
//
//  Migrated to new Ignite API
//

import Foundation
import Ignite

struct Dues: StaticPage {
    @Environment(\.articles) var articles

    var title = "Class Dues"
    var description: String = "Pay your Princeton Class of 2000 dues. Choose from annual, five-year, or lifetime plans to support class activities and events."
    var image: URL? = URL(string: "/images/logos/P2000_25th_Lounging_Tiger.svg")

    var body: some HTML {
        Group {
            Text("Dues")
                .font(.title1)
                .fontWeight(.semibold)

            for content in articles.typed("dues") {
                Text(content.text)
            }
        }
        .padding(.horizontal, 20)
    }
}
