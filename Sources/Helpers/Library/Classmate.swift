//
//  Classmate.swift
//  Princeton2000
//
//  Classmate model for library entries
//

import Foundation

struct Classmate: Codable, Comparable, Hashable {
    static func < (lhs: Classmate, rhs: Classmate) -> Bool {
        return lhs.lastName < rhs.lastName && lhs.firstName < rhs.firstName
    }

    let firstName: String
    let lastName: String
    var id: String { return "\(lastName.lowercased())\(String(firstName.first ?? Character("")))" }
    var description: String { return "\(firstName) \(lastName)" }
}
