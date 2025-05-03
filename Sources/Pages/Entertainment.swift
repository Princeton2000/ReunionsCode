//
//  Entertainment.swift
//
//
//  Created by Justin Purnell on 7/8/24.
//

import Foundation
import Ignite

struct Entertainment: StaticPage {
	var title = "Class Dues"
	var description: String = "Pay your dues…we need them!!"
	var image: String? = "/images/logos/P2000_25th_Lounging_Tiger.svg"

	func body(context: PublishingContext) -> [BlockElement] {
		Include("entertainmentGuide/index.html")
	}
}
