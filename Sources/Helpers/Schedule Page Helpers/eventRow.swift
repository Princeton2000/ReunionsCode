//
//  File.swift
//  IgniteStarter
//
//  Created by Justin Purnell on 8/12/24.
//

import Foundation
import Ignite

//func eventRow(_ events: [Event], day value: Int) -> [Row] {
//	var rows: [Row] = []
//	for event in events.filter({$0.startComponents.weekday == value}) {
//		let row =
//			Row {
////				Image(systemName: eventTypeIcon(event.type).0).foregroundStyle(.princetonOrange)
////				Text("\(eventTypeIcon(event.type).1)").horizontalAlignment(.center)
//				Text(event.eventStartEnd)/*.frame(width: 160, alignment: .leading)*/
////				if let _ = event.description {
////					Accordion {
////						Item(event.name) {
////							Text(event.description!)
////						}
////					}
////				} else {
////					Text(event.name)
////				}
//				Text(event.name)/*.fontWeight(.medium).frame(width: 200, alignment: .leading)*/
//				Text(event.primaryLocation)/*.frame(width: 200, alignment: .leading)*/
//			}
//		rows.append(row)
//		}
//	return rows
//}


import Foundation
import Ignite

func eventRow(_ events: [Event], day value: Int) -> [Row] {
	var rows: [Row] = []
	for event in events.filter({$0.startComponents.weekday == value}) {
		let row =
			Row {
				Text("\(eventTypeIcon(event.type).1)").frame(minWidth: 20, maxWidth: 20).horizontalAlignment(.center).hint(text: event.type.rawValue)
				Text(event.eventStartEnd).frame(minWidth: 120, maxWidth: 120, alignment: .leading)
				Text(event.name).fontWeight(.medium).frame(minWidth: 200, maxWidth: 800, alignment: .leading)
					.hint(text: event.description == "" ? (event.eventSummary == "" ? event.name : event.eventSummary) : event.description)
				Link(Text(event.primaryLocation), target: event.primaryLocationID!).target(.newWindow)
			}
		rows.append(row)
		}
	return rows
}
