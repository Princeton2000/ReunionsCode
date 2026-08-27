//
//  Reunion.swift
//  Princeton2000
//
//  Single source of truth for the upcoming Reunion's dates and labels.
//

import Foundation

/// The upcoming Reunion, and every label the site derives from it.
///
/// Dates and reunion-year copy used to be spelled out separately in `Site`, `MainLayout`,
/// `Home`, and `ClassHome`. Because `MainLayout`'s registration banner is gated on
/// `isUpcoming`, its copy sat dormant — and therefore un-updated — for a full year, then
/// reappeared advertising a stale year the moment the dates rolled forward. Deriving every
/// string from one value keeps a dormant call site from drifting away from a live one.
///
/// To roll the site over to the next Reunion, edit `Reunion.upcoming` and nothing else.
struct Reunion: Sendable {
    /// Which Reunion this is: 27 for the 27th Reunion.
    var ordinal: Int

    /// First day, at the hour the Reunion opens.
    var start: DateComponents

    /// Last day, at the hour the Reunion closes.
    var end: DateComponents

    /// Class-specific registration link for this Reunion.
    var registrationURL: String

    /// Whether registration has opened. Drives "Register now" vs. "come back soon" copy.
    var registrationIsOpen: Bool

    // MARK: - The one value to edit

    static let upcoming = Reunion(
        ordinal: 27,
        start: DateComponents(
            calendar: .current,
            timeZone: TimeZone(identifier: "America/New_York"),
            year: 2027, month: 5, day: 20,
            hour: 12, minute: 0, second: 0
        ),
        end: DateComponents(
            calendar: .current,
            timeZone: TimeZone(identifier: "America/New_York"),
            year: 2027, month: 5, day: 23,
            hour: 10, minute: 0, second: 0
        ),
        registrationURL: "https://princeton.reunioniq.com/go/2027/satellite10-35",
        registrationIsOpen: true
    )
}

// MARK: - Derived dates

extension Reunion {
    /// Falls back to the epoch only if `start` is malformed; callers treat this as a real date.
    var startDate: Date { start.date ?? Date(timeIntervalSince1970: 0) }

    var endDate: Date { end.date ?? Date(timeIntervalSince1970: 0) }

    /// The calendar year of the Reunion, e.g. 2027.
    var year: Int { start.year ?? 0 }

    /// True until the Reunion ends. Gates the registration banner.
    var isUpcoming: Bool { Date() < endDate }

    var startISO8601: String { startDate.asISO8601 }

    var endISO8601: String { endDate.asISO8601 }
}

// MARK: - Derived labels

extension Reunion {
    /// Deterministic formatting for a static site: fixed locale, fixed time zone.
    private func monthName(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = start.timeZone ?? .current
        formatter.dateFormat = "MMMM"
        return formatter.string(from: date)
    }

    private func day(_ components: DateComponents) -> Int { components.day ?? 0 }

    /// "27th"
    var ordinalLabel: String { "\(ordinal)\(Self.ordinalSuffix(ordinal))" }

    /// "27th Reunion"
    var title: String { "\(ordinalLabel) Reunion" }

    /// "Princeton Class of 2000 — 27th Reunion"
    var eventName: String { "Princeton Class of 2000 — \(title)" }

    /// "Reunions 2027"
    var yearLabel: String { "Reunions \(year)" }

    /// "May 20-23", spanning months when needed ("May 30 - June 2").
    var dayRange: String {
        let startMonth = monthName(startDate)
        let endMonth = monthName(endDate)
        if startMonth == endMonth {
            return "\(startMonth) \(day(start))-\(day(end))"
        }
        return "\(startMonth) \(day(start)) - \(endMonth) \(day(end))"
    }

    /// "May 20-23, 2027"
    var dateRange: String { "\(dayRange), \(year)" }

    /// "May 20 through May 23, 2027" — for prose.
    var longDateRange: String {
        "\(monthName(startDate)) \(day(start)) through \(monthName(endDate)) \(day(end)), \(year)"
    }

    /// "Reunions 2027 is May 20-23 – Register Now!", or the pre-registration variant.
    var callToAction: String {
        registrationIsOpen
            ? "\(yearLabel) is \(dayRange) – Register Now!"
            : "\(yearLabel) is \(dayRange)…come back soon to register!"
    }

    private static func ordinalSuffix(_ value: Int) -> String {
        // 11th, 12th, 13th break the usual 1st/2nd/3rd pattern.
        if (11...13).contains(value % 100) { return "th" }
        switch value % 10 {
        case 1: return "st"
        case 2: return "nd"
        case 3: return "rd"
        default: return "th"
        }
    }
}
