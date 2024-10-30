//
//  Copyright.swift
//  IgniteStarter
//
//  Created by Justin Purnell on 8/5/24.
//

import Foundation
import Ignite

public struct Copyright: Component {
	var calendar: Calendar = .current
	var year: Int { return Calendar.current.component(.year, from: Date())}
	
	public func body(context: PublishingContext) -> [any PageElement] {
			//		Section {
		Text {
			"© \(year) Princeton Class of 2000. All Rights Reserved."
		}.font(.title6).foregroundStyle(.tertiary).addCustomAttribute(name: "style", value:  "font: 1rem/4.0;")
		Text {
			"Created with "
			Link("Ignite", target: URL("https://github.com/twostraws/Ignite"))
		}.font(.title6).foregroundStyle(.tertiary).addCustomAttribute(name: "style", value:  "font: 1rem/4.0;")
			//		}.width(.max)
	}
	
	public init() {}
	
}
