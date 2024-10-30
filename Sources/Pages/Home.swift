import Foundation
import Ignite

struct Home: StaticPage {
    var title = "Home"

    func body(context: PublishingContext) -> [BlockElement] {
		Section {
			Group {
				Include("countdown.js").horizontalAlignment(.center)
			}.horizontalAlignment(.center)
		}.padding(.horizontal, 5)
		Section {
			Group {
				if deployment() == .production {
					Text("Look back on Reunions").font(.title3).fontWeight(.semibold)
					Embed(vimeoID: [950880962, 831352768, 713233083].first!, title: "Reunions").aspectRatio(.r16x9)
				} else {
					Text("Commencement 2000").font(.title3).fontWeight(.semibold)
					Embed(youTubeID: "Tr8X5kst0bs", title: "Reunions")
						.aspectRatio(.r4x3)
				}
			}
			.width(8)
			Group {
				Text("The Latest on Reunions 2025…").font(.title3).fontWeight(.semibold).horizontalAlignment(.center)
				Divider()
				for content in context.content(ofType: "letters").filter({$0.metadata["hidden"] as? String != "true"}).sorted(by: {getDate($0.metadata["lastModified"] as? String ?? "") > getDate($1.metadata["lastModified"] as? String ?? "")}) {
					Quote {
						Text {
							Link("\(content.metadata["title"] as! String)", target: content.path)
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
