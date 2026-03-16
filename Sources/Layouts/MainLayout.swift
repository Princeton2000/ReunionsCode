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
        calendar: .autoupdatingCurrent,
        timeZone: .autoupdatingCurrent,
        year: 2025, month: 5, day: 22,
        hour: 12, minute: 0, second: 0
    )
    var reunionsEndDate = DateComponents(
        calendar: .autoupdatingCurrent,
        timeZone: .autoupdatingCurrent,
        year: 2025, month: 5, day: 24,
        hour: 10, minute: 0, second: 0
    )

    var body: some Document {
        Head {
            MetaLink(href: "/css/fonts.css", rel: .stylesheet)
            MetaLink(href: "/css/theme.css", rel: .stylesheet)
            MetaLink(href: "/css/layout.css", rel: .stylesheet)
            Script(code: """
                function updateSocialIcons() {
                    var isDark = document.documentElement.getAttribute('data-bs-theme')?.includes('dark');
                    document.querySelectorAll('img[src*="/images/social/"]').forEach(function(img) {
                        img.style.filter = isDark ? 'invert(1)' : '';
                    });
                }
                new MutationObserver(updateSocialIcons).observe(
                    document.documentElement, { attributes: true, attributeFilter: ['data-bs-theme'] }
                );
                document.addEventListener('DOMContentLoaded', updateSocialIcons);
            """)
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
                        Link("Reunions is May 22-25, 2025 – Register Now!", target: "https://princeton.reunioniq.com/go/2025/2000")
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

    // Helper to generate FAQ accordion based on current page
    @HTMLBuilder
    private func faqAccordion() -> some HTML {
        let pageTitleLower = page.title.lowercased()
        let filteredFAQs = articles.typed("faq").filter { article in
            article.tags?.map { $0.lowercased() }.contains(pageTitleLower) ?? false
        }.sorted { ($0.tags?.first ?? "") < ($1.tags?.first ?? "") }

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
