//
//  ClassHome.swift
//  Princeton2000
//
//  Embeddable class homepage for www.princeton2000.org iframe
//

import Foundation
import Ignite

struct ClassHome: StaticPage {
    @Environment(\.articles) var articles

    var title = "Class of 2000"
    var path = "/class-home"
    var layout: EmbedLayout { EmbedLayout() }

    var body: some HTML {
        Section {
//            Image("/images/logos/P2000_25th_Lounging_Tiger.svg",
//                  description: "Princeton Class of 2000 Tiger")
//                .resizable()
//                .frame(maxWidth: 300)
//                .style(.display, "block")
//                .style(.margin, "0 auto")
            

            Text("Welcome to the Website of the Great Class of 2000!")
                .class("tayLennon")
                .font(.title1)
                .fontWeight(.semibold)
                .horizontalAlignment(.center)
                .padding(.top)

            Text {
                "We are a volunteer organization run by and for the Princeton undergraduate Class of 2000. Enabled by the Trustees of Princeton University, our mission is to deepen the connections that our classmates have with each other, with the University, with other Classes, and with the community."
            }
            .horizontalAlignment(.center)
            .padding(.horizontal, 5)
            .padding(.bottom)
        }
        .padding(.top)

        Section {
            Section {
                Text("Links")
                    .class("tayLennon")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding(.top)

                Grid {
                    linkCard("Class Notes", description: "2000 in the news", target: "https://reunions.princeton2000.org/notes")
                    linkCard("Library", description: "Check out some of the incredible work by our classmates", target: "https://reunions.princeton2000.org/library")
					
					linkCard("Honorary Classmates", description: "Our adopted members", target: "https://reunions.princeton2000.org/honorary-classmates")
					linkCard("Leadership", description: "Officers and class leadership", target: "https://reunions.princeton2000.org/leadership")
					
					linkCard("Class Dues", description: "Support class events and the PAW", target: "https://www.princeton2000.org/memberships")
					linkCard("Class Store", description: "Get exclusive Class of 2000 merch", target: "https://tinyurl.com/2000store")
                    
                    linkCard("TigerNet", description: "Access the Forums and Alumni Directory", target: "https://tigernet.princeton.edu")
					linkCard("Your Homepage", description: "Complete your TigerNet profile!", target: "https://tigernet.princeton.edu/login?redirect_to=%2Fpage%2Fmy-homepage")
                }
                .columns(2)
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
                        .filter({ $0.type == "letters" })
                        .sorted(by: { ($0.lastModified) > ($1.lastModified) })
                        .prefix(4) {
                        letterPreviewRow(content)
                    }
                }
            }
            .width(4)
        }
        .class("row")
        .padding(.horizontal, 5)
        .padding(.bottom)

        Section {
            Text {
                Link("Visit our Reunions site", target: "https://reunions.princeton2000.org")
                    .target(.top)
                    .linkStyle(.button)
                    .role(.primary)
            }
            .horizontalAlignment(.center)
            .padding(.bottom)
        }
    }

    private func linkCard(_ title: String, description: String, target: String) -> some HTML {
        Card {
            Text(description)
                .font(.body)
        } header: {
            Link(title, target: "\(target)")
                .target(.top)
        }
        .margin(.bottom)
    }
}
