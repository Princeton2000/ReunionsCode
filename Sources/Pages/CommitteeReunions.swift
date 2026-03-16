//
//  CommitteeReunions.swift
//  Princeton2000
//
//  Migrated to new Ignite API
//

import Foundation
import Ignite

struct CommitteeReunions: StaticPage {
    @Environment(\.decode) var decode

    var title = "2025 Reunions Committee"
    var description: String = "Your incredible Reunions Committee"
    var image: URL? = URL(string: "/images/logos/P2000_25th_Lounging_Tiger.svg")

    var body: some HTML {
        Table {
            if let committee = decode("leadership.json", as: [CommitteeMember].self)?
                .filter({ $0.priority < 3 && $0.priority > 0 })
                .sorted(by: { $0.priority < $1.priority && $0.role < $1.role && $0.lastName < $1.lastName && $0.firstName < $1.firstName }) {
                for members in committee.batched(into: 3) {
                    Row {
                        for member in members {
                            Column {
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
                                Text(member.name)
                                    .fontWeight(.semibold)
                                Text(member.role)
                            }
                            .horizontalAlignment(.center)
                        }
                    }
                }
            }
        }
    }
}
