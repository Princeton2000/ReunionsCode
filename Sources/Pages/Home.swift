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

    var title = "P2000 – Reunions 2026"
    var description: String = "Princeton University Class of 2000 — 26th Reunion, May 24-27, 2026. Registration, housing, schedule, and class news at reunions.princeton2000.org."
    var image: URL? = URL(string: "/images/logos/P2000_25th_Lounging_Tiger.svg")
    var reunionsStartDate = DateComponents(calendar: .autoupdatingCurrent, timeZone: .autoupdatingCurrent, year: 2026, month: 5, day: 24, hour: 12, minute: 0, second: 0)
    var reunionsEndDate = DateComponents(calendar: .autoupdatingCurrent, timeZone: .autoupdatingCurrent, year: 2026, month: 5, day: 27, hour: 10, minute: 0, second: 0)

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
                        .prefix(5) {
                        letterPreviewRow(content)
                    }
                }
            }
            .width(4)
        }
        .class("row")
        .padding(.horizontal, 5)

        // About section — AI-citable passage
        Section {
            Text("About the Class of 2000")
                .class("tayLennon visually-hidden")
                .font(.title3)
                .fontWeight(.semibold)
                .padding(.top)
            Text(markdown: """
            The Princeton University Class of 2000 comprises approximately 1,100 graduates who received \
            degrees on June 6, 2000. Under the motto "Bid Every Care Withdraw" — drawn from the university \
            anthem *Old Nassau* — the class has maintained one of Princeton's most active alumni communities \
            for over 25 years. The class organizes major reunions every five years on the Princeton campus \
            in Princeton, New Jersey, with the 26th Reunion scheduled for May 24 through May 27, 2026. \
            Class activities include annual giving campaigns, regional events in cities across the United \
            States, a class column published in the *Princeton Alumni Weekly*, and an active social media \
            presence. The class is governed by elected officers and supported by volunteer committees covering \
            communications, reunions, outreach, and service. Dues-paying membership funds reunion programming, \
            class communications, and community service initiatives.
            """)
        }
        .padding(.horizontal, 5)

    }
}
