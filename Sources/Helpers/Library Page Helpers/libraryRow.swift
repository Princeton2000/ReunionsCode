	//
	//  libararyRow.swift
	//  IgniteStarter
	//
	//  Created by Justin Purnell on 9/3/24.
	//

import Foundation
import Ignite

func libraryRow(_ libraryEntry: LibraryEntry, includeDivider: Bool = true) -> Row {
	let row =
	Row {
		Image(libraryEntry.image ?? "", description: libraryEntry.title).frame(minWidth: 100, maxWidth: 300, height: 300, minHeight: 150).resizable().hint(text: libraryEntry.title ?? "")
			Group {
				Text(libraryEntry.title ?? "").font(.title2).fontWeight(.semibold)
				Text(libraryEntry.description?.replacingOccurrences(of: "\n", with: "<br>") ?? "")
				for link in libraryEntry.links.filter({$0.url != nil }) {
					if link.source == .vimeo {
						Accordion {
							Item("Watch Here") {
								Embed(vimeoID: Int((link.url?.replacingOccurrences(of: "https://vimeo.com/", with: ""))!)!, title: "\(libraryEntry.title ?? "")").aspectRatio(.r16x9).padding(.top, 450)
								Spacer()
							}
						}.padding(.vertical, 10)
					} else
					if link.source == .youtube {
						Accordion {
							Item("Watch Here") {
								Embed(youTubeID: (link.url?.replacingOccurrences(of: "https://www.youtube.com/watch?v=", with: ""))!, title: "\(libraryEntry.title ?? "")").aspectRatio(.r16x9).padding(.top, 450)
								Spacer()
							}
						}.padding(.vertical, 10)
					}
				}
			}
		Row {
			Column {
				for link in libraryEntry.links.filter({$0.url != nil }) {
					Link(
						Image(libraryLinkList.first(where: {$0.source == link.source})!.logoImage, description: "Find \(libraryEntry.title ?? "") by \(libraryEntry.classmate.firstName) \(libraryEntry.classmate.lastName) on \(link.source.rawValue)").resizable().frame(maxWidth: 100).padding(.trailing).opacity(0.75), target: link.url ?? "#").target(.newWindow).relationship(.noOpener, .noReferrer).id("\(libraryEntry.title ?? "") at \(link.source.rawValue)")
				}
					includeDivider ? Divider() : Spacer()
			}.columnSpan(.max)
		}.addCustomAttribute(name: "style", value: "border-style: hidden")
//		.horizontalAlignment(.leading)
	}
	.addCustomAttribute(name: "style", value: "border-style: hidden")
	return row
}


