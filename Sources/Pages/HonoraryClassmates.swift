//
//  HonoraryClassmates.swift
//  Princeton2000
//
//  Migrated to new Ignite API
//

import Foundation
import Ignite

struct HonoraryClassmates: StaticPage {
    @Environment(\.decode) var decode

    var title = "Honorary Classmates"
    var description: String = "Meet the distinguished honorary members of the Princeton Class of 2000, recognized for their contributions to the University and beyond."
    var image: URL? = URL(string: "/images/logos/P2000_25th_Lounging_Tiger.svg")

    var body: some HTML {
        if let honoraryClassmates = decode("honoraryClassmate.json", as: [HonoraryClassmate].self) {
            Section {
                for member in honoraryClassmates.sorted(by: <) {
                    Section {
                        Card {
                            Text {
                                Link("\(member.description)", target: "/honorary/\(member.lastName.lowercased())")
                                    .target(.newWindow)
                                    .relationship(.noOpener, .noReferrer)
                            }
                            .font(.title4)
                            .fontWeight(.semibold)
                        } header: {
                            Image("/images/honoraryClassmates/\(member.lastName.lowercased()).png", description: "Photo of \(member.firstName) \(member.lastName)")
                                .resizable()
                                .frame(maxHeight: 200)
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
