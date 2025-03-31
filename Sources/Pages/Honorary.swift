//
//  Housing.swift
//
//
//  Created by Justin Purnell on 7/8/24.
//

import Foundation
import Ignite

struct Crew: StaticPage {
	var title = "Crew"
	var description: String = "Our Outstanding Reunions Crew"
	var image: String? = "/images/logos/P2000_25th_Lounging_Tiger.svg"

	func body(context: PublishingContext) -> [BlockElement] {
		var crewMembers: [CrewMember] { let decoder = JSONDecoder(); let data = try! Data(contentsOf: URL(fileURLWithPath: "/Users/jpurnell/Dropbox/Computer/Development/Swift/Princeton/Website/ExampleSite/Resources/crew.json")); let crew = try? decoder.decode([CrewMember].self, from: data); return crew?.sorted(by: < ) ?? []}
		Section {
			for member in crewMembers.sorted(by: < ) {
				Card {
					Text(markdown: member.summary)
				} header: {
					Image("/images/crew/\(member.lastName.lowercased())\(member.firstName).png", description: "Photo of crew member \(member.firstName) \(member.lastName)").class("none").resizable().frame(height: 200)
					Text("\(member.firstName) \(member.lastName) '\(member.year % 2000)").font(.title4).fontWeight(.semibold)
					Text("\(member.role)").font(.title6).fontWeight(.regular)
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
