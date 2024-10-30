//
//  GearCard.swift
//  IgniteStarter
//
//  Created by Justin Purnell on 10/7/24.
//

import Foundation
import Ignite

struct Merch: Codable {
	let image: String
	let name: String
	let priority: Int
	let description: String
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

func merchCard(_ merch: Merch) -> Card {
	Card(imageName: merch.image) {
		Text("\(merch.description)").font(.title6)
		if let chart = merch.sizeChart { sizeChart(chart) }
	}
	header: { merch.name }
	.frame(maxWidth: 500)
	.contentPosition(.top)
	.imageOpacity(1.0)
}
