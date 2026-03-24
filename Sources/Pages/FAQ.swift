//
//  FAQ.swift
//  Princeton2000
//
//  FAQ index page — all questions grouped by tag
//

import Foundation
import Ignite

struct FAQ: StaticPage {
    @Environment(\.articles) var articles

    var title = "FAQ"
    var description: String = "Frequently asked questions about Princeton Class of 2000 reunions — registration, housing, jackets, transportation, and more."
    var path = "faq"

    var allFAQs: [Article] {
        articles.typed("faq").filter { $0.metadata["question"] != nil }
    }

    /// All unique tags sorted alphabetically, with display-friendly names.
    var sortedTags: [String] {
        let tags = Set(allFAQs.flatMap { $0.tags ?? [] })
        return tags.sorted()
    }

    /// FAQs grouped by their first tag.
    func faqsForTag(_ tag: String) -> [Article] {
        allFAQs.filter { ($0.tags ?? []).contains(tag) }
            .sorted { ($0.metadata["question"] as? String ?? "") < ($1.metadata["question"] as? String ?? "") }
    }

    /// Formats a tag slug into a display name.
    func displayName(for tag: String) -> String {
        tag.split(separator: "-")
            .map { $0.prefix(1).uppercased() + $0.dropFirst() }
            .joined(separator: " ")
    }

    var body: some HTML {
        Text("Frequently Asked Questions").font(.title1)

        Text("Find answers to common questions about Princeton Class of 2000 reunions — registration, housing, the P-rade, and more.")
            .margin(.bottom, 20)

        for tag in sortedTags {
            let faqs = faqsForTag(tag)
            if !faqs.isEmpty {
                Text(displayName(for: tag))
                    .font(.title3)
                    .fontWeight(.semibold)
                    .margin(.top, 30)

                Accordion {
                    for faq in faqs {
                        Item(faq.metadata["question"] as? String ?? faq.title) {
                            Text(markdown: faq.text)
                        }
                    }
                }
            }
        }
    }
}
