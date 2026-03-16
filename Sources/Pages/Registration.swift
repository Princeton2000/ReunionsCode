//
//  Registration.swift
//  Princeton2000
//
//  Migrated to new Ignite API
//

import Foundation
import Ignite

struct Registration: StaticPage {
    @Environment(\.articles) var articles

    var title = "Registration"
    var description = "Register for Princeton Class of 2000 Reunions."

    var body: some HTML {
        for content in articles.typed("registration").filter({ !(($0.tags ?? []).contains("walk-up")) }) {
            Text(content.text)
                .padding([.leading, .trailing])
        }

        Text("Pricing")
            .padding([.leading, .vertical])
            .font(.title3)
            .fontWeight(.semibold)
            .background(.princetonOrange)
            .padding(.vertical)

        Table {
            Row {
                "Classmate Only (3-day)"
                "$650"
                "$750"
            }
            Row {
                "Adult Guest (3-day)"
                "$650"
                "$750"
            }
            Row {
                "Child (Ages 3-20) (3-day)"
                "$250"
                "$250"
            }
            Row {
                Column {
                    "🐅"
                }
                .columnSpan(4)
                .horizontalAlignment(.trailing)
            }
            Row {
                "Classmate Only (Saturday Only)"
                "$325"
                "$350"
            }
            Row {
                "Adult Guest (Saturday Only)"
                "$325"
                "$350"
            }
            Row {
                "Child (Ages 3-20) (Saturday Only)"
                "$125"
                "$125"
            }
        } header: {
            "Guest Type"
            "Regular Registration<br>(1/1/2025 - 5/14/2025)"
            "Late Registration<br>(5/15/2025 - )"
        }
        .padding([.leading, .trailing])

        Divider()

        musicEmbed(teaserText: "While you register…get into the mood with some Reunions Jams?")
    }
}
