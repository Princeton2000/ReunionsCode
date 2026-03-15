//
//  Officers.swift
//  Princeton2000
//
//  Migrated to new Ignite API
//

import Foundation
import Ignite

struct Officers: StaticPage {
    @Environment(\.decode) var decode

    var title = "Class of 2000 Officers"
    var description: String = "Your Class Officers"
    var image: URL? = URL(string: "/images/logos/P2000_25th_Lounging_Tiger.svg")

    var body: some HTML {
        Table {
            if let officers = decode("leadership.json", as: [CommitteeMember].self)?
                .filter({ $0.priority == 0 })
                .sorted(by: { $0.lastName < $1.lastName }) {
                for members in officers.batched(into: 2) {
                    Row {
                        for member in members {
                            Card {
                                Link(member.role, target: "mailto:\(member.email)")
                            } header: {
                                Image(member.photo, description: member.name)
                                    .resizable()
                                    .frame(height: 200)
                                    .style(.objectFit, "cover")
                                Text("\(member.name) '00")
                                    .font(.title4)
                                    .fontWeight(.semibold)
                            }
                            .frame(height: .percent(97.5%))
                            .width(4)
                            .horizontalAlignment(.center)
                            .margin(.bottom)
                            .padding(.horizontal, 5)
                        }
                    }
                }
            }
        }
    }
}
