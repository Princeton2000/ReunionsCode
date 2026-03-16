//
//  JacketPreLaunch.swift
//  Princeton2000
//
//  Migrated to new Ignite API
//

import Foundation
import Ignite

struct JacketPreLaunch: StaticPage {
    @Environment(\.articles) var articles

    var title = "Jacket"
    var description: String = "Preview and FAQ for the Princeton Class of 2000 25th Reunion jacket, including sizing, ordering deadlines, and tailoring tips."
    var image: URL? = URL(string: "/images/logos/P2000_25th_Lounging_Tiger.svg")

    let jacketUpdateImages = (1...22).map { "/images/jacket/presentation/Slide\($0).png" }
    let jacketTestSlides = (1...22).map { "/images/jacket/testSlides/testSlides.\(String(format: "%03d", $0)).png" }

    var jacketFaqArticles: [Article] {
        articles.typed("faq")
            .filter { ($0.tags ?? []).contains("jacket") }
            .sorted(by: { ($0.tags?.first ?? "") < ($1.tags?.first ?? "") })
    }

    var body: some HTML {
        Alert {
            Text("They're working on it!")
                .fontWeight(.semibold)
                .horizontalAlignment(.center)
            Text {
                Link("While you wait, make sure it fits! Here's our measuring guide to make sure you get the perfect fit.", target: "/images/jacket/P2000_25th_Jacket_Sizing_Chart.pdf")
                    .target(.newWindow)
                    .relationship(.noOpener, .noReferrer)
            }
            .fontWeight(.semibold)
            .horizontalAlignment(.center)
        }
        .role(.danger)
        .padding()

        Divider()

        Accordion {
            for content in jacketFaqArticles {
                Item(content.metadata["question"] as? String ?? content.title) {
                    Text(markdown: content.text)
                }
            }
        }
    }
}
