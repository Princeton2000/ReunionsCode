import Foundation
import Ignite

struct Home: StaticPage {
    var title = "P2000 – Reunions 2025"
	var image: String? = "/images/logos/P2000_25th_Lounging_Tiger.svg"
	var reunionsStartDate = DateComponents(calendar: .autoupdatingCurrent, timeZone: .autoupdatingCurrent, year: 2025, month: 5, day: 22, hour: 12, minute: 0, second: 0)
	var reunionsEndDate = DateComponents(calendar: .autoupdatingCurrent, timeZone: .autoupdatingCurrent, year: 2025, month: 5, day: 24, hour: 10, minute: 0, second: 0)

    func body(context: PublishingContext) -> [BlockElement] {
		if Date() < reunionsEndDate.date ?? Date() {
			Section {
				Group {
					Include("countdown.js")
						.horizontalAlignment(.center)
				}
				.horizontalAlignment(.center)
			}
			.padding(.horizontal, 5)
		}
		Section {
//			Group {
//				Text("Commencement 2000")
//					.class("tayLennon")
//					.font(.title3)
//					.fontWeight(.semibold)
//					.padding(.top)
//				Embed(youTubeID: "Tr8X5kst0bs",
//					  title: "Reunions")
//					.aspectRatio(.r4x3)
//			}
			Group {
				Text("Reunions 2025")
					.class("tayLennon")
					.font(.title3)
					.fontWeight(.semibold)
					.padding(.top)
				Embed(vimeoID: 1087610735, title: "Reunions 2025")
					.aspectRatio(.r16x9)
			}
			.width(8)
			Group {
				Text("The Latest")
					.class("tayLennon")
					.font(.title3)
					.fontWeight(.semibold)
					.padding(.top)
				for content in context
					.content(ofType: "letters")
					.sorted(by: {
						getDate($0.metadata["lastModified"] as? String ?? "") >
						getDate($1.metadata["lastModified"] as? String ?? "")
								}
					)[0...5]
				{
					Quote {
						Divider()
						Text {
							Link("\(content.metadata["title"] as! String)",
								 target: content.path)
							.target(.newWindow)
							.relationship(.noOpener, .noReferrer)
						}
					} caption : {
						"\(formatDate(content.metadata["lastModified"] as? String ?? "", .short, .short))"
				   }
				}
			}
			.width(4)
		}.padding(.horizontal, 5)
    }
}
