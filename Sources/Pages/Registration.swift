//
//  Housing.swift
//
//
//  Created by Justin Purnell on 7/8/24.
//

import Foundation
import Ignite

struct Registration: StaticPage {
	var title = "Registration"

	func body(context: PublishingContext) -> [BlockElement] {
		for content in context.content(ofType: "registration").filter({!$0.tags.contains("walk-up")}) {
			Text(content.body).padding([.leading, .trailing])
		}
		
		Text("Pricing").padding([.leading, .vertical]).font(.title3).fontWeight(.semibold).background(.antiqueWhite).padding(.vertical)

		Table {
			Row {
				"Classmate Only (3-day)"
				"$500"
				"$650"
				"$750"
			}
			Row {
				"Adult Guest (3-day)"
				"$500"
				"$650"
				"$750"
			}
			Row {
				"Child (Ages 3-20) (3-day)"
				"$200"
				"$250"
				"$250"
			}
			Row {
				Column {
					"🐅"
				}
			.columnSpan(4)
			.horizontalAlignment(.trailing)
			}
			Row {
				"Classmate Only (Saturday Only)"
				"$250"
				"$325"
				"$350"
			}
			Row {
				"Adult Guest (Saturday Only)"
				"$250"
				"$325"
				"$350"
			}
			Row {
				"Child (Ages 3-20) (Saturday Only)"
				"$100"
				"$125"
				"$125"
			}
		} header: {
			"Guest Type"
			"Early Bird<br>(11/1/2024 - 12/31/2024)"
			"Regular Registration<br>(1/1/2025 - 5/14/2025)"
			"Late Registration<br>(5/15/2025 - )"
		}.padding([.leading, .trailing])
		Divider()
		musicEmbed(teaserText: "While you register…get into the mood with some Reunions Jams?")
	}
}
