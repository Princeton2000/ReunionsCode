//
//  File.swift
//  IgniteStarter
//
//  Created by Justin Purnell on 8/7/24.
//

import Foundation
struct Event: Codable {
	let name: String
	var published: Bool
	var startDateString: String
	var startDate: Date { let df = ISO8601DateFormatter(); df.formatOptions = [.withFullDate, .withFullTime]; return df.date(from: startDateString) ?? df.date(from: "2020-01-01T00:00:00Z")! }
	var startComponents: DateComponents { return Calendar.current.dateComponents([.year, .month, .day, .weekday, .hour, .minute], from: startDate) }
	var endDateString: String
	var endDate: Date { let df = ISO8601DateFormatter(); df.formatOptions = [.withFullDate, .withFullTime]; return df.date(from: endDateString) ?? df.date(from: "2020-01-01T00:00:00Z")! }
	var endComponents: DateComponents { return Calendar.current.dateComponents([.year, .month, .day, .weekday, .hour, .minute, .timeZone], from: endDate)
	}
	var description: String?
	
// MARK: - Refactor to use eventStartEnd as the schedule variable
	var eventStartEnd: String {
		let tf = DateFormatter()
			tf.dateFormat = "h:mma"
		return "\(tf.string(from: startDate)) - \(tf.string(from: endDate))"
	}
	
		// MARK: - Add runTime that gives a string with h:mm:ss of end time minus start time
	var runTime: String {
		let df = DateFormatter()
		let tf = DateComponentsFormatter()
			df.dateFormat = "MMM d, yyyy h:mma"
			df.dateFormat = "h:mma"
		tf.allowedUnits = [.hour, .minute, .second]
		let timeInterval = endDate.timeIntervalSince(startDate)
		return "\(tf.string(from: timeInterval) ?? "00:00:00")"
	}

	// MARK: - Add
	var type: EventType
	var location: String
	var placeID: String?
	var contingencyLocation: String?
	var contingencyPlaceID: String?
	var eventSummary: String?
	var summary: String {
		return "\(type.rawValue)\t\t\(runTime)\t\t\(name)\t\t\(location)"}
}
