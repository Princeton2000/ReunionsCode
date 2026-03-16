//
//  BidEveryCareWithdraw.swift
//  Princeton2000
//
//  Migrated to new Ignite API
//

import Foundation
import Ignite

struct BidEveryCareWithdraw: StaticPage {
    @Environment(\.articles) var articles

    var title = "Bid Every Care Withdraw"
    var description: String = "The story behind 'Bid Every Care Withdraw,' the Princeton Class of 2000 25th Reunion theme drawn from Old Nassau."
    var image: URL? = URL(string: "/images/logos/P2000_25th_Lounging_Tiger.svg")

    let jacketUpdateImages = (1...22)
        .map { "/images/jacket/testSlides/testSlide.\(String(format: "%03d", $0)).png" }

    var themeFaqArticles: [Article] {
        articles.typed("faq")
            .filter { ($0.tags ?? []).contains("theme") }
            .sorted(by: { ($0.tags?.first ?? "") < ($1.tags?.first ?? "") })
    }

    var body: some HTML {
        Section {
            Image("/images/logos/P2000_25th_Lounging_Tiger.svg",
                  description: "The Bid Every Care Withdraw Logo")
                .resizable()
                .frame(height: 300)
        }
        .horizontalAlignment(.center)

        Spacer()

        Section {
            Text("Bid Every Care Withdraw")
                .class("tayLennon")
                .font(.title1)
                .foregroundStyle(.princetonOrange)
        }
        .horizontalAlignment(.center)

        Divider()

        Text("Our Theme")
            .class("tayLennon")
            .font(.title1)
            .padding([.leading])

        Section {
            for content in articles.typed("theme") {
                Text(content.text)
                    .padding([.leading, .trailing])
            }
        }
        .padding(.horizontal)

        Section {
            // Carousel placeholder
        }
        .horizontalAlignment(.center)

        Accordion {
            for content in themeFaqArticles {
                Item(content.metadata["question"] as? String ?? content.title) {
                    Text(markdown: content.text)
                }
            }
        }
    }
}
