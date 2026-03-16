//
//  Apparel.swift
//  Princeton2000
//
//  Apparel/merchandise models and helpers
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
    var title: String = "Size Chart"
    let headers: [String]
    let rows: [[String]]
}

@MainActor
func sizeChart(_ chart: SizeChart) -> some HTML {
    Accordion {
        Item(chart.title) {
            Table {
                for row in chart.rows {
                    Row {
                        for info in row {
                            Column { info }
                        }
                    }
                }
            } header: {
                for header in chart.headers {
                    Column { header }
                }
            }
            .tableStyle(.stripedRows)
        }
    }
    .openMode(.individual)
    .margin(.bottom, 10)
}

@MainActor
func apparelCard(_ apparel: Apparel) -> some HTML {
    if apparel.image.isEmpty {
        Card {
            Text("\(apparel.description)")
                .font(.title6)
            if let chart = apparel.sizeChart {
                sizeChart(chart)
            }
        } header: {
            apparel.name
        }
        .frame(maxWidth: 500)
    } else {
        Card(imageName: apparel.image) {
            Text("\(apparel.description)")
                .font(.title6)
            if let chart = apparel.sizeChart {
                sizeChart(chart)
            }
        } header: {
            apparel.name
        }
        .frame(maxWidth: 500)
    }
}
