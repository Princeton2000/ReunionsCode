//
//  ScheduleHelpers.swift
//  Princeton2000
//
//  Schedule display helpers (dailyBlock and eventRow)
//

import Foundation
import Ignite

@MainActor
func dailyBlock(_ events: [Event], dayNumber: Int, blurb: String) -> Group {
    let d = DateFormatter()
    d.dateFormat = "cccc"
    let date = DateComponents(calendar: .current, timeZone: .current, weekday: dayNumber).date!
    guard !events.isEmpty else {
        print("No events scheduled for \(d.string(from: date))")
        return Group {}
    }
    print("getting events for \(dayNumber): \(events.filter({ $0.startComponents.weekday == dayNumber }).count)")

    return Group {
        Text("\(d.string(from: date))")
            .padding([.leading, .vertical])
            .font(.title2)
            .fontWeight(.semibold)
            .background(.princetonOrange)
            .margin(.none)

        Text("\(blurb)")
            .padding()

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

@MainActor
func eventRow(_ events: [Event], day value: Int) -> [Row] {
    var rows: [Row] = []
    for event in events.filter({ $0.startComponents.weekday == value }) {
        let row = Row {
            Text("\(eventTypeIcon(event.type).1)")
                .frame(minWidth: 20, maxWidth: 20)
                .horizontalAlignment(.center)
                .hint(text: event.type.rawValue)
            Text(event.eventStartEnd)
                .frame(minWidth: 120, maxWidth: 120, alignment: .leading)
            Text(event.name)
                .fontWeight(.medium)
                .frame(minWidth: 200, maxWidth: 800, alignment: .leading)
                .hint(text: event.description == "" ? (event.eventSummary == "" ? event.name : event.eventSummary) : event.description)
            Link(event.primaryLocation, target: event.primaryLocationID!)
                .target(.newWindow)
        }
        rows.append(row)
    }
    return rows
}
