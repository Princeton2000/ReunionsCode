//
//  Housing.swift
//
//
//  Created by Justin Purnell on 7/8/24.
//

import Foundation
import Ignite

struct HonoraryClassmates: StaticPage {
	var title = "Honorary Classmates"
	var description: String = "Our Distinguished Honorary Classmates"
	var image: String? = "/images/logos/P2000_25th_Lounging_Tiger.svg"

	func body(context: PublishingContext) -> [BlockElement] {
		if let honoraryClassmates = context.decode(resource: "honoraryClassmate.json", as: [HonoraryClassmate].self) {
			Section {
				for member in honoraryClassmates.sorted(by: < ) {
					Card {
						Text {
							Link("\(member.description)", target: "/honorary/\(member.lastName.lowercased())")
														.target(.newWindow)
														.relationship(.noOpener, .noReferrer)
						}
						.font(.title4)
						.fontWeight(.semibold)
					} header: {
						Image("/images/honoraryClassmates/\(member.lastName.lowercased()).png", description: "Photo of \(member.firstName) \(member.lastName)").class("none").resizable().frame(maxHeight: 200)
					}
					.frame(height: "97.5%")
					.width(3)
					.horizontalAlignment(.center)
					.margin(.bottom)
					.padding(.horizontal, 5)
				}
			}
		}
	}
}
