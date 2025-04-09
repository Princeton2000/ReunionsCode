//
//  File.swift
//  IgniteStarter
//
//  Created by Justin Purnell on 8/6/24.
//

import Foundation
import Ignite

struct TableVideo: StaticPage {
	var title = "Keep It Fun"

	func body(context: PublishingContext) -> [BlockElement] {
		Image("/images/banners_adam.jpg", description: "Pally").resizable()
		Image("/images/parties_are_fun2.jpg", description: "Parties").resizable().padding(.leading, "400px")
		Group {
			Text(markdown:"FUN**UMENTARY**").fontWeight(.ultraLight).font(.title1)
		}
		.foregroundStyle(.princetonOrange)
		Divider()
		Section {
			Group {
				Table {
					Row {
						Column {
							Row {
								Text {
									Button("What Does Fun Mean to You?") {
										ShowElement("Part1")
										HideElement("Part2")
										HideElement("Part3")
										HideElement("Part4")
									}
									.role(.default)
								}
								.foregroundStyle(.princetonOrange)
							}
							Row {
								Text {
									Button("Music, Margaritas, and Memories") {
										HideElement("Part1")
										ShowElement("Part2")
										HideElement("Part3")
										HideElement("Part4")
									}
									.role(.default)
								}
								.foregroundStyle(.princetonOrange)
							}
							Row {
								Text {
									Button("Celebrities") {
										HideElement("Part1")
										HideElement("Part2")
										ShowElement("Part3")
										HideElement("Part4")
									}
									.role(.default)
								}
								.foregroundStyle(.princetonOrange)
							}
							Row {
								Text {
									Button("I Keep It Fun") {
										HideElement("Part1")
										HideElement("Part2")
										HideElement("Part3")
										ShowElement("Part4")
									}
									.role(.default)
								}
								.foregroundStyle(.princetonOrange)
							}
						}
						.verticalAlignment(.middle)
					}
				}
				.tableBorder(false)
				.tableStyle(.plain)
		}
			.width(3)
			Group {
				Embed(vimeoID: 995536358, title: "Part 1 - What Does Fun Mean to You?").id("Part1").aspectRatio(.r4x3).frame(width: 640, height: 480)
				Embed(vimeoID: 995536293, title: "Part 2 - Music, Margaritas, and Memories").id("Part2").aspectRatio(.r4x3).frame(width: 640, height: 480).hidden()
				Embed(vimeoID: 995537638, title: "Part 3 - Celebrities").id("Part3").aspectRatio(.r4x3).frame(width: 640, height: 480).hidden()
				Embed(vimeoID: 995536238, title: "Part 4 - I Keep It Fun").id("Part4").aspectRatio(.r4x3).frame(width: 640, height: 480).hidden()
			}
			.padding(.all, "15px")
			.width(6)
			Group {
				Table {
					Row {
						Text{"Hi"}
					}
					Row {
						Text{"Hello"}
					}
					Row {
						Text{"Third"}
					}
				}
				.tableBorder(false)
				.tableStyle(.plain)
			}.width(3)
		}
	}
}
