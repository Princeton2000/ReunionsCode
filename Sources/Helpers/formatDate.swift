//
//  formatDate.swift
//  Princeton2000
//
//  Date formatting utilities
//

import Foundation
import Ignite

func getDate(_ string: String) -> Date {
    let iso8601Formatter = ISO8601DateFormatter()
    let date = iso8601Formatter.date(from: string)
    return date ?? Date()
}

func formatDate(
    _ string: String,
    _ dateStyle: DateFormatter.Style = .medium,
    _ timeStyle: DateFormatter.Style = .medium
) -> String {
    let df = DateFormatter()
    df.dateStyle = dateStyle
    df.timeStyle = timeStyle
    return df.string(from: getDate(string))
}

func formatDate(
    _ date: Date?,
    _ dateStyle: DateFormatter.Style = .medium,
    _ timeStyle: DateFormatter.Style = .medium
) -> String {
    guard let date = date else { return "" }
    let df = DateFormatter()
    df.dateStyle = dateStyle
    df.timeStyle = timeStyle
    return df.string(from: date)
}
