//
//  Home.swift
//  Princeton2000
//
//  Home page
//

import Foundation
import Ignite

struct Home: StaticPage {
    @Environment(\.articles) var articles

    var title = "P2000 – Reunions 2025"
    var image: String? = "/images/logos/P2000_25th_Lounging_Tiger.svg"
    var reunionsStartDate = DateComponents(calendar: .autoupdatingCurrent, timeZone: .autoupdatingCurrent, year: 2025, month: 5, day: 22, hour: 12, minute: 0, second: 0)
    var reunionsEndDate = DateComponents(calendar: .autoupdatingCurrent, timeZone: .autoupdatingCurrent, year: 2025, month: 5, day: 24, hour: 10, minute: 0, second: 0)

    var body: some HTML {
        if Date() < reunionsEndDate.date ?? Date() {
            Section {
                Group {
                    Include("countdown.js")
                        .horizontalAlignment(.center)
                }
                .horizontalAlignment(.center)
            }
            .padding(.horizontal, 5)
        }
        Section {
            Section {
                Text("Our 25th Reunion")
                    .class("tayLennon")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding(.top)
                Embed(youTubeID: "tlLpViZPwAs", title: "Our 25th Reunion")
                    .aspectRatio(.r16x9)
            }
            .width(8)
            Section {
                Text("The Latest")
                    .class("tayLennon")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding(.top)
                Table {
                    for content in articles
                        .all
                        .filter({ $0.type == "notes" || $0.type == "letters" })
                        .sorted(by: { ($0.lastModified ?? Date.distantPast) > ($1.lastModified ?? Date.distantPast) })
                        .prefix(6) {
                        letterPreviewRow(content)
                    }
                }
            }
            .width(4)
        }
        .class("row")
        .padding(.horizontal, 5)
    }
}
