//
//  Housing.swift
//
//
//  Created by Justin Purnell on 7/8/24.
//

import Foundation
import Ignite

struct Committee: StaticPage {
	var title = "Committee"

	func body(context: PublishingContext) -> [BlockElement] {
		var committee: [CommitteeMember] { let decoder = JSONDecoder(); let data = try! Data(contentsOf: URL(fileURLWithPath: "/Users/jpurnell/Dropbox/Computer/Development/Swift/Princeton/Website/ExampleSite/Resources/committee.json")); let committeeMembers = try? decoder.decode([CommitteeMember].self, from: data); return committeeMembers?.sorted(by: {$0.priority < $1.priority && $0.role < $1.role}) ?? []}
		
		Table {
			for members in committee.batched(into: 3) {
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
