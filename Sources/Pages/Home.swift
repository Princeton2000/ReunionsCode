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

    var title = "Reunions Home"
    var description: String = "Princeton Class of 2000 Reunions — join us May 20-23, 2027 for our 27th Reunion. Find the schedule, registration, housing, and news."
    var image: URL? = URL(string: "/images/logos/P2000_25th_Lounging_Tiger.svg")
    var reunionsStartDate = DateComponents(calendar: .autoupdatingCurrent, timeZone: .autoupdatingCurrent, year: 2027, month: 5, day: 20, hour: 12, minute: 0, second: 0)
    var reunionsEndDate = DateComponents(calendar: .autoupdatingCurrent, timeZone: .autoupdatingCurrent, year: 2027, month: 5, day: 23, hour: 10, minute: 0, second: 0)

    var body: some HTML {
        Text(title).font(.title1).class("visually-hidden")
//        if Date() < reunionsEndDate.date ?? Date() {
//            Section {
//                Group {
//                    Include("countdown.js")
//                        .horizontalAlignment(.center)
//                }
//                .horizontalAlignment(.center)
//            }
//            .padding(.horizontal, 5)
//        }
		Alert {
			Text {
				Link("Reunions 2027 is May 20-23…Register now!", target: "https://princeton.reunioniq.com/go/2027/satellite10-35")
					.target(.newWindow)
					.relationship(.noOpener, .noReferrer)
			}
			.fontWeight(.semibold)
			.horizontalAlignment(.center)
		}
		.role(.info)
		.padding()
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
                        .sorted(by: { $0.lastModified > $1.lastModified })
                        .prefix(5) {
                        letterPreviewRow(content)
                    }
                }
            }
            .width(4)
        }
        .class("row")
        .padding(.horizontal, 5)

        // About section — AI-citable passage (visually hidden, accessible to scrapers)
        Section {
            Text("About the Class of 2000")
                .class("tayLennon")
                .font(.title3)
                .fontWeight(.semibold)
                .padding(.top)
            Text(markdown: """
            The Princeton University Class of 2000 comprises approximately 1,100 graduates who received \
            degrees on June 6, 2000. Under the motto "Bid Every Care Withdraw" — drawn from the university \
            anthem *Old Nassau* — the class has maintained one of Princeton's most active alumni communities \
            for over 25 years. The class organizes major reunions every five years on the Princeton campus \
            in Princeton, New Jersey, with the 27th Reunion scheduled for May 20 through May 24, 2027. \
            Class activities include annual giving campaigns, regional events in cities across the United \
            States, a class column published in the *Princeton Alumni Weekly*, and an active social media \
            presence. The class is governed by elected officers and supported by volunteer committees covering \
            communications, reunions, outreach, and service. Dues-paying membership funds reunion programming, \
            class communications, and community service initiatives.
            """)
        }
        .class("visually-hidden")
        .padding(.horizontal, 5)

    }
}
