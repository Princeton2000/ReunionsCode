//
//  MainLayout.swift
//  Princeton2000
//
//  Migrated from MainTheme.swift to new Ignite Layout API
//

import Foundation
import Ignite

struct MainLayout: Layout {
    @Environment(\.articles) var articles
    @Environment(\.page) var page

    var reunionsStartDate = DateComponents(
        calendar: .current,
		timeZone: .init(abbreviation: "EST"),
        year: 2027, month: 5, day: 20,
        hour: 12, minute: 0, second: 0
    )
    var reunionsEndDate = DateComponents(
        calendar: .autoupdatingCurrent,
        timeZone: TimeZone(identifier: "EST"),
        year: 2027, month: 5, day: 23,
        hour: 2, minute: 0, second: 0
    )

    var body: some Document {
        Head {
            MetaLink(href: "/css/fonts.css", rel: .stylesheet)
            MetaLink(href: "/css/theme.css", rel: .stylesheet)
            MetaLink(href: "/css/layout.css", rel: .stylesheet)
            Script(code: """
                var s = document.createElement('style');
                s.textContent = '[data-bs-theme*=\"dark\"] img[src*=\"social\"] { filter: invert(1) !important; } [data-bs-theme*=\"dark\"] img[src*=\"TigerHead_BECW\"] { filter: invert(1) hue-rotate(180deg) !important; } [data-bs-theme*=\"dark\"] img[src*=\"Lounging_Tiger\"] { filter: invert(1) hue-rotate(180deg) !important; } [data-bs-theme*=\"dark\"] img[src*=\"headshots/P2000_25th_TigerHead\"] { filter: invert(1) !important; } [data-bs-theme*=\"dark\"] img[src*=\"apple_music_logo\"] { filter: invert(1) !important; } [data-bs-theme*=\"dark\"] img[src*=\"AmazonMusicLogo\"] { filter: invert(1) !important; } [data-bs-theme*=\"dark\"] img[src*=\"Amazon_logo\"] { filter: invert(1) !important; } [data-bs-theme*=\"dark\"] img[src*=\"Amazon_Prime_Video_logo\"] { filter: invert(1) !important; } [data-bs-theme*=\"dark\"] img[src*=\"Apple_TV_logo\"] { filter: invert(1) !important; } [data-bs-theme*=\"dark\"] img[src*=\"bandcamp_logo\"] { filter: invert(1) !important; } [data-bs-theme*=\"dark\"] img[src*=\"bookshop\"] { filter: invert(1) !important; } [data-bs-theme*=\"dark\"] img[src*=\"Disney\"] { filter: invert(1) !important; } [data-bs-theme*=\"dark\"] img[src*=\"ParamountPlus\"] { filter: invert(1) !important; }';
                document.head.appendChild(s);
            """)

            // Structured data (JSON-LD)
            StructuredData("Organization", properties: [
                "name": "Princeton Class of 2000",
                "url": "https://reunions.princeton2000.org",
                "logo": "https://reunions.princeton2000.org/images/logos/P2000_25th_TigerHead_BECW.svg",
                "description": "Official website of the Princeton University Class of 2000, organizing reunions, class activities, and community engagement since 2000.",
                "foundingDate": "2000-06-06",
                "sameAs": socialLinkList.map(\.link),
                "knowsAbout": ["Princeton University", "Alumni Relations", "Class Reunions"],
                "contactPoint": [
                    "@type": "ContactPoint",
                    "contactType": "alumni relations",
                    "email": "social+web@princeton2000.org",
                    "url": "https://reunions.princeton2000.org/officers/"
                ] as [String: Any],
                "parentOrganization": [
                    "@type": "Organization",
                    "name": "Princeton University",
                    "url": "https://www.princeton.edu"
                ] as [String: Any]
            ] as [String: Any])

            StructuredData.webSite(
                name: "Princeton Class of 2000",
                url: "https://reunions.princeton2000.org",
                description: "Official site of the Princeton University Class of 2000 — reunions, class notes, and alumni engagement."
            )

            StructuredData.breadcrumbs()

            StructuredData.article(
                publisher: "Princeton Class of 2000",
                publisherURL: "https://reunions.princeton2000.org"
            )

            if page.url.path == "/" || page.url.path.isEmpty {
                StructuredData.event(
                    name: "Princeton Class of 2000 — 27th Reunion",
					startDate: "\(reunionsStartDate.date?.asISO8601 ?? "2027-05-20")",
                    endDate: "\(reunionsEndDate.date?.asISO8601 ?? "2027-05-23")",
                    locationName: "Princeton University",
                    locality: "Princeton",
                    region: "NJ",
                    postalCode: "08544",
                    organizer: (name: "Princeton Class of 2000", url: "https://reunions.princeton2000.org")
                )
            }

            // FAQPage schema — full set on /faq/, scoped subset on other pages
            if page.url.path.contains("faq") {
                faqPageSchema()
            } else {
                let pageFAQs = faqsForCurrentPage()
                if !pageFAQs.isEmpty {
                    faqPageSchema(from: pageFAQs)
                }
            }
        }

        Body {
            // Google Tag Manager (body snippet)
            Include("/analytics/gtmBody.html")

            // Navigation
            NavBar()

            // Registration Alert (only show before reunions end)
            if Date() < reunionsEndDate.date ?? Date() {
                Alert {
                    Text {
                        Link("Reunions 2027 is May 20-23 – Register Now!", target: "https://princeton.reunioniq.com/go/2027/satellite10-35")
                            .target(.newWindow)
                            .relationship(.noOpener, .noReferrer)
                    }
                    .font(.title4)
                    .fontWeight(.semibold)
                    .horizontalAlignment(.center)
                }
                .role(.secondary)
            }

            // Main page content
            content

            // Page-specific FAQ Accordion
            faqAccordion()

            Divider()

            // Social links
            Group {
                SocialLinks()
            }
            .padding(.horizontal)

            // Instagram embed
            Group {
                Include("instagramEmbed.html")
            }
            .padding(.horizontal)

            Spacer()

            // Footer
            Copyright()
        }
    }

    // FAQs matching the current page title by tag
    private func faqsForCurrentPage() -> [Article] {
        let pageTitleLower = page.title.lowercased()
        return articles.typed("faq").filter { article in
            article.tags?.map { $0.lowercased() }.contains(pageTitleLower) ?? false
        }.sorted { ($0.tags?.first ?? "") < ($1.tags?.first ?? "") }
    }

    // FAQPage JSON-LD schema — all FAQs (for /faq/) or a scoped subset
    private func faqPageSchema(from subset: [Article]? = nil) -> StructuredData {
        let faqArticles = subset ?? articles.typed("faq").filter { $0.metadata["question"] != nil }
        let qaEntries: [[String: Any]] = faqArticles.compactMap { faq in
            guard let question = faq.metadata["question"] as? String else { return nil }
            return [
                "@type": "Question",
                "name": question,
                "acceptedAnswer": [
                    "@type": "Answer",
                    "text": faq.text
                ] as [String: Any]
            ] as [String: Any]
        }
        return StructuredData("FAQPage", properties: [
            "mainEntity": qaEntries
        ] as [String: Any])
    }

    // Helper to generate FAQ accordion based on current page
    @HTMLBuilder
    private func faqAccordion() -> some HTML {
        let filteredFAQs = faqsForCurrentPage()

        if !filteredFAQs.isEmpty {
            Accordion {
                for faq in filteredFAQs {
                    Item(faq.metadata["question"] as? String ?? faq.title) {
                        Text(markdown: faq.text)
                    }
                }
            }
        }
    }
}
