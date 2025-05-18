//
//  GearCard.swift
//  IgniteStarter
//
//  Created by Justin Purnell on 10/7/24.
//

import Foundation
import Ignite

struct Apparel: Codable {
	let image: String
	let name: String
	let priority: Int
	let description: String
	let link: String?
	let sizeChart: SizeChart?
}

struct SizeChart: Codable {
	var title: String  = "Size Chart"
	let headers: [String]
	let rows: [[String]]
}

func sizeChart(_ chart: SizeChart) -> Accordion {
	Accordion {
		Item(chart.title) {
			Table {
				for row in chart.rows {
					Row {
						row.map({info in Column { info }})
					}
				}
			} header: {
				chart.headers.map({header in Column { header }})
			}.tableStyle(.stripedRows)
		}
	}.openMode(.individual).margin(.bottom, 10)
}

func apparelCard(_ apparel: Apparel) -> Card {
	Card(imageName: apparel.image) {
		Text("\(apparel.description)").font(.title6)
//		if (apparel.link != nil) { Button { Link("Buy Now", target: apparel.link!) } }
		if let chart = apparel.sizeChart { sizeChart(chart) }
	}
	header: { apparel.name }
	.frame(maxWidth: 500)
	.contentPosition(.top)
	.imageOpacity(1.0)
}
