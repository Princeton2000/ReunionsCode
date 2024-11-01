import Foundation
import Ignite

struct Home: StaticPage {
    var title = "Home"
	var description: String = "Bid Every Care Withdraw: Princeton 2000s 25th Reunion, May 22-25, 2025"
	var image: String? = "/images/logos/P2000_25th_Lounging_Tiger.svg"

    func body(context: PublishingContext) -> [BlockElement] {
		Section {
			Group {
				Include("countdown.js")
					.horizontalAlignment(.center)
			}
			.horizontalAlignment(.center)
		}
		.padding(.horizontal, 5)
		Section {
			Group {
				Text("Commencement 2000")
					.class("tayLennon")
					.font(.title3)
					.fontWeight(.semibold)
					.padding(.vertical)
				Embed(youTubeID: "Tr8X5kst0bs",
					  title: "Reunions")
					.aspectRatio(.r4x3)
			}
			.width(8)
			Group {
				Text("The Latest")
					.class("tayLennon")
					.font(.title3)
					.fontWeight(.semibold)
					.padding(.vertical)
				for content in context
					.content(ofType: "letters")
					.filter({$0.metadata["hidden"] as? String != "true"})
					.sorted(by: {
						getDate($0.metadata["lastModified"] as? String ?? "") >
						getDate($1.metadata["lastModified"] as? String ?? "")
								}
					)
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
