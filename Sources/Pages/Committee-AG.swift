//
//  Committee-AG.swift
//
//
//  Created by Justin Purnell on 7/8/24.
//

import Foundation
import Ignite

struct CommitteeAG: StaticPage {
	var title = "2025 Annual Giving Committee"
	var description: String = "Your incredible Annual Giving Committee"
	var image: String? = "/images/logos/P2000_25th_Lounging_Tiger.svg"

	func body(context: PublishingContext) -> [BlockElement] {	
		Table {
			if let committee = context.decode(resource: "leadership.json", as: [CommitteeMember].self)?.filter({$0.priority >= 3}).sorted(by: {$0.priority < $1.priority && $0.role < $1.role && $0.lastName < $1.lastName }) {
				for members in committee.batched(into: 4) {
					Row {
						for member in members {
							Column {
								member.photo == "" ?
								Image.tiger.resizable().frame(height: 200) :
								Image(member.photo, description: member.name).resizable().frame(height: 200)
								Text(member.name).fontWeight(.semibold)
								Text(member.role)
							}.horizontalAlignment(.center)
						}
					}
				}
			}
		}
	}
}
