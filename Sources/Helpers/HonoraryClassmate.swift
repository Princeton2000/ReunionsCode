//
//  HonoraryClassmate.swift
//  Princeton2000
//
//  Honorary classmate model
//

import Foundation

struct HonoraryClassmate: Codable, Comparable {
    static func < (lhs: HonoraryClassmate, rhs: HonoraryClassmate) -> Bool {
        if lhs.priority != rhs.priority {
            return lhs.priority < rhs.priority
        } else {
            return lhs.lastName < rhs.lastName
        }
    }

    let firstName: String
    let lastName: String
    let role: String
    let year: Int?
    let priority: Int
    let photo: String
    let email: String
    let summary: String
    var description: String { "\(firstName) \(lastName)" }
}
