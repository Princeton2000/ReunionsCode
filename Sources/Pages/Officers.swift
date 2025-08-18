//
//  Committee-AG.swift
//
//
//  Created by Justin Purnell on 7/8/24.
//

import Foundation
import Ignite

struct Officers: StaticPage {
	var title = "Class of 2000 Officers"
	var description: String = "Your Class Officers"
	var image: String? = "/images/logos/P2000_25th_Lounging_Tiger.svg"

	func body(context: PublishingContext) -> [BlockElement] {
		Table {
			if let officers = context.decode(resource: "officers.json", as: [CommitteeMember].self)?.sorted(by: {$0.priority < $1.priority && $0.role < $1.role}) {
				for members in officers.batched(into: 2) {
					Row {
						for member in members {
							Card {
								Link(target: "mailto:\(member.email)",
									 content: {
									Text(markdown: member.role)
										.font(.title6)
										.fontWeight(.medium)
								})
							} header: {
								Image(member.photo, description: member.chair) .resizable().frame(height: 200)
								Text("\(member.chair) '00").font(.title4).fontWeight(.semibold)
							}
							.frame(height: "97.5%")
							.width(4)
							.horizontalAlignment(.center)
							.margin(.bottom)
							.padding(.horizontal, 5)
						}
					}
					
//					Row {
//						for member in members {
//							Column {
//								member.photo == "" ?
//								Image.tiger.resizable().frame(width: 150, height: 150) :
//								Image(member.photo, description: member.chair).resizable().frame(width: 150, height: 150)
//								Text(member.chair).fontWeight(.semibold)
//								Link(target: "mailto:\(member.email)", content: {Text(member.role)})
//								
//							}.horizontalAlignment(.center)
//						}
//					}
				}
			}
		}
	}
}
