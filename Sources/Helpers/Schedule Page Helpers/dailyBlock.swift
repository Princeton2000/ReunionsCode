//
//  File.swift
//  IgniteStarter
//
//  Created by Justin Purnell on 8/12/24.
//

import Foundation
import Ignite

func dailyBlock(_ events: [Event], dayNumber: Int, blurb: String) -> Group {
	let d = DateFormatter()
	d.dateFormat = "cccc"
	let date = DateComponents(calendar: .current, timeZone: .current, weekday: dayNumber).date!
	guard !events.isEmpty else { print("No events scheduled for \(d.string(from: date))"); return Group {} }
	return Group {
		Text("\(d.string(from: date))")
			.padding([.leading, .vertical])
			.font(.title2)
			.fontWeight(.semibold)
			.background(.princetonOrange)
			.margin(.none)
		Text("\(blurb)").padding()
		Table {
			for row in eventRow(events, day: dayNumber) {
				row
			}
		} header: {
			"Type"
			"Time"
			"Activity"
			"Location"
		}
		.tableBorder(false)
		.padding(.horizontal)
	}
}
