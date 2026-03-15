//
//  Event.swift
//  Princeton2000
//
//  Event model for schedule
//

import Foundation

struct Event: Codable {
    let name: String
    var type: EventType
    var startDateString: String
    var endDateString: String
    var primaryLocation: String
    var primaryLocationID: String?
    var contingencyLocation: String?
    var contingencyLocationID: String?
    var eventSummary: String
    var description: String
    var fullDescription: String {
        return "\(type.rawValue)\t\t\(runTime)\t\t\(name)\t\t\(primaryLocation)"
    }
    var organizer: String?
    var ticketed: Bool?
    var link: String?
    var published: Bool

    var startDate: Date {
        let df = ISO8601DateFormatter()
        df.formatOptions = [.withFullDate, .withFullTime]
        return df.date(from: startDateString) ?? df.date(from: "2020-01-01T00:00:00Z")!
    }

    var startComponents: DateComponents {
        return Calendar.current.dateComponents([.year, .month, .day, .weekday, .hour, .minute], from: startDate)
    }

    var endDate: Date {
        let df = ISO8601DateFormatter()
        df.formatOptions = [.withFullDate, .withFullTime]
        return df.date(from: endDateString) ?? df.date(from: "2020-01-01T00:00:00Z")!
    }

    var endComponents: DateComponents {
        return Calendar.current.dateComponents([.year, .month, .day, .weekday, .hour, .minute, .timeZone], from: endDate)
    }

    var eventStartEnd: String {
        let tf = DateFormatter()
        tf.dateFormat = "h:mma"
        return "\(tf.string(from: startDate)) - \(tf.string(from: endDate))"
    }

    var runTime: String {
        let tf = DateComponentsFormatter()
        tf.allowedUnits = [.hour, .minute, .second]
        let timeInterval = endDate.timeIntervalSince(startDate)
        return "\(tf.string(from: timeInterval) ?? "00:00:00")"
    }

    var summary: String {
        return "\(type.rawValue)\t\t\(runTime)\t\t\(name)\t\t\(primaryLocation)"
    }
}
