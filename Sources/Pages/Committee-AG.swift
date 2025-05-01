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
			if let committee = context.decode(resource: "committee.json", as: [CommitteeMember].self)?.filter({$0.priority >= 2}).sorted(by: {$0.priority < $1.priority && $0.role < $1.role}) {
				for members in committee.batched(into: 4) {
					Row {
						for member in members {
							Column {
								member.photo == "" ?
								Image.tiger.resizable().frame(width: 100, height: 100) :
								Image(member.photo).resizable().frame(width: 100, height: 100)
								Text(member.chair).fontWeight(.semibold)
								Text(member.role)
							}.horizontalAlignment(.center)
						}
					}
				}
			}
		}
	}
}
