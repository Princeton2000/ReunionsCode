//
//  Leadership.swift
//  Princeton2000
//
//  Migrated to new Ignite API
//

import Foundation
import Ignite

struct Leadership: StaticPage {
    @Environment(\.decode) var decode

    var title = "Class of 2000 Leadership"
    var description: String = "Your Class Leadership"
    var image: URL? = URL(string: "/images/logos/P2000_25th_Lounging_Tiger.svg")

    var body: some HTML {
        Grid {
            if let officers = decode("leadership.json", as: [CommitteeMember].self)?
			.sorted(by: { $0.priority < $1.priority && $0.lastName < $1.lastName }) {
                for member in officers {
                    Card {
                        Link(member.role, target: "mailto:\(member.email)")
                    } header: {
                        if member.photo == "" {
                            Image.tiger
                                .resizable()
                                .frame(height: 200)
                                .style(.objectFit, "contain")
                        } else {
                            Image(member.photo, description: member.name)
                                .resizable()
                                .frame(height: 200)
                                .style(.objectFit, "contain")
                        }
                        Text("\(member.name) '00")
                            .font(.title4)
                            .fontWeight(.semibold)
                    }
                    .horizontalAlignment(.center)
                    .margin(.bottom)
                }
            }
        }
        .columns(3)
    }
}
