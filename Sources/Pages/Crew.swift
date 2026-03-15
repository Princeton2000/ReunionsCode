//
//  Crew.swift
//  Princeton2000
//
//  Migrated to new Ignite API
//

import Foundation
import Ignite

struct Crew: StaticPage {
    @Environment(\.decode) var decode

    var title = "Meet our Crew"
    var description: String = "Our Outstanding Reunions Crew"
    var image: URL? = URL(string: "/images/logos/P2000_25th_Lounging_Tiger.svg")

    var body: some HTML {
        if let crewMembers = decode("crew.json", as: [CrewMember].self) {
            Section {
                for member in crewMembers.sorted(by: <) {
                    Section {
                        Card {
                            Text(markdown: member.summary)
                        } header: {
                            Image("/images/crew/\(member.lastName.lowercased())\(member.firstName).png", description: "Photo of crew member \(member.firstName) \(member.lastName)")
                                .resizable()
                                .frame(height: 200)
                            Text("\(member.firstName) \(member.lastName) '\(member.year % 2000)")
                                .font(.title4)
                                .fontWeight(.semibold)
                            Text("\(member.role)")
                                .font(.title6)
                                .fontWeight(.regular)
                        }
                        .frame(height: .percent(97.5%))
                        .horizontalAlignment(.center)
                        .margin(.bottom)
                    }
                    .width(3)
                }
            }
            .class("row")
        }
    }
}
