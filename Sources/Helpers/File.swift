//
//  File.swift
//  IgniteStarter
//
//  Created by Justin Purnell on 5/14/25.
//

import Foundation
import Ignite

extension Link: @retroactive Equatable {
	public static func == (lhs: Link, rhs: Link) -> Bool {
		return lhs.url == rhs.url
	}
	
	public static func < (lhs: Link, rhs: Link) -> Bool {
		return lhs.url < rhs.url
	}
}

extension Link: @retroactive Hashable {
	public func hash(into hasher: inout Hasher) {
		url.hash(into: &hasher)
	}
}
