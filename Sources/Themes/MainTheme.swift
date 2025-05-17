import Foundation
import Ignite

struct MyTheme: Theme {
	var reunionsStartDate = DateComponents(calendar: .autoupdatingCurrent, timeZone: .autoupdatingCurrent, year: 2025, month: 5, day: 22, hour: 12, minute: 0, second: 0)
	var reunionsEndDate = DateComponents(calendar: .autoupdatingCurrent, timeZone: .autoupdatingCurrent, year: 2025, month: 5, day: 24, hour: 10, minute: 0, second: 0)
    func render(page: Page, context: PublishingContext) -> HTML {
        HTML {
			Head(for: page, in: context) {
				MetaTag(name: "Last-Modified", content: "\(Date().asISO8601)")
//				MetaTag(name: "description", content: "\(Princeton2000().description) - \(page.description)")
				MetaTag(property: "og:type", content: "website")
				MetaTag(property: "og:image:type", content: "image/png")
				MetaTag(property: "og:image", content: "\(deployment().rawValue)/images/logos/P2000_25th_TigerHead_BECW.png")
				MetaTag(property: "og:title", content: "Bid Every Care Withdraw: 25th Reunion, May 22-25, 2025")
				if page.title == "Merch" {
					MetaTag(httpEquiv: "refresh", content: "0; url=https://princeton.reunioniq.com/shop/classof00")
				}
				MetaTag(name: "fediverse:creator", content: "@princeton2000@mastodon.social")
				MetaLink(href: "/css/css_add-ins.css", rel: "stylesheet")
				MetaLink(href: "https://mastodon.social/@princeton2000", rel: "me")
				deployment() == .production ? Script(code: """
(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
					   new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
		j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
		'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
		})(window,document,'script','dataLayer','GTM-TT98XLGL');
""") : Script(string: "")
				Script(file: "https://analytics.ahrefs.com/analytics.js\" data-key=\"n6eM095/RZ9GaCjlJX7thQ\"")
			}
            Body {
				Include("/analytics/gtmBody.html")
				if Date() < reunionsEndDate.date ?? Date() {
					Text("\(reunionsEndDate.date?.asISO8601)")
				}
				NavBar()
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
					}.role(.secondary)
				}
                page.body
				Accordion {
					for content in context.content(ofType: "faq").filter({$0.tags.map({$0.lowercased()	}) .contains("\(String(describing: page.title.lowercased))")}).sorted(by: {$0.tags[0] < $1.tags[0]}) {
						Item(content.metadata["question"] as! InlineElement) {
							Text(markdown: content.body)
						}
					}
				}
				Divider()
				Group { SocialLinks() }.padding(.horizontal)
				Group { Include("instagramEmbed.html") }.padding(.horizontal)
				Spacer()
				Copyright()
            }
        }
    }
}
