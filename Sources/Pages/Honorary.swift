//
//  Housing.swift
//
//
//  Created by Justin Purnell on 7/8/24.
//

import Foundation
import Ignite

struct HonoraryClassmates: StaticPage {
	var title = "Crew"
	var description: String = "Our Outstanding Reunions Crew"
	var image: String? = "/images/logos/P2000_25th_Lounging_Tiger.svg"

	func body(context: PublishingContext) -> [BlockElement] {
		if let honoraryClassmates = context.decode(resource: "honoraryClassmate.json", as: [HonoraryClassmate].self) {
			Section {
				for member in honoraryClassmates.sorted(by: < ) {
					Card {
					} header: {
						Image("/images/honoraryClassmates/\(member.lastName.lowercased()).png", description: "Photo of \(member.firstName) \(member.lastName)").class("none").resizable().frame(height: 200)
						Text("\(member.description)").font(.title4).fontWeight(.semibold)
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
