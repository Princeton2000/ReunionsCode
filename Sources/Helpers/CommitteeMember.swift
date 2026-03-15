//
//  CommitteeMember.swift
//  Princeton2000
//
//  Committee member model for leadership/officers
//

import Foundation

struct CommitteeMember: Codable {
    let firstName: String
    let lastName: String
    let chair: String
    let role: String
    let photo: String
    let email: String
    let priority: Int
    var name: String { "\(firstName) \(lastName)" }
}
