import Foundation
import Ignite

struct Home: StaticPage {
    var title = "P2000 – Reunions 2025"
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
					.padding(.top)
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
					.padding(.top)
//				Table {
//					for content in context
//						.content(ofType: "letters")
//						.sorted(by: {
//							getDate($0.metadata["lastModified"] as? String ?? "") >
//							getDate($1.metadata["lastModified"] as? String ?? "")
//									}
//						)[0...7] {
//						Row {
//							Image(content.image ?? image!, description: content.imageDescription).resizable().frame(maxWidth: 200, maxHeight: 100, alignment: .leading)
//							Text {
//								Link("\(content.metadata["title"] as! String)",
//									 target: content.path)
//								.target(.newWindow)
//								.relationship(.noOpener, .noReferrer)
//							}
//							Text("\(formatDate(content.metadata["lastModified"] as? String ?? "", .short, .short))")
//						}
//					}
//				}
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
