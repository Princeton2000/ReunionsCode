//
//  Housing.swift
//
//
//  Created by Justin Purnell on 7/8/24.
//

import Foundation
import Ignite

struct Schedule: StaticPage {
	var title = "Schedule"
	typealias dayData = (Int, String)
	let dayBlurbs: [dayData] = [(5, "Come back and see what’s changed! We’ll have family activities and a chance for people to ease back into life on campus at our headquarters in Whitman College."), (6, "We will host breakfast, lunch, and family activities at headquarters, and we will offer a community service event at HQ in the afternoon. Move on over to Jadwin Gym for our Class Cocktail Reception (5:30-6:30 pm) and Class Dinner (6:30-8:30 pm). Then party down with TBA and TBA in the evening."), (7, "Join us for a special class brunch and our class photo, then show off your new jacket and flair in the P-rade!\nLook out for  Alumni Faculty Forums with panelists from the Class of 2000!"), (1, "Closing time, to quote Semisonic.\nGrab some breakfast as you head out with your memories and begin your Reunions recovery.")]
	
	func body(context: PublishingContext) -> [BlockElement] {
//		Alert {
//			Text(markdown: "**PLEASE NOTE:** This is just an indicative schedule, based off the '98s and '99s recent weekends. Come back frequently as we fill in details!").fontWeight(.semibold).horizontalAlignment(.center)
//		}.role(.info)
		if let events = context.decode(resource: "events.json", as: [Event].self)?.sorted(by: { $0.startDate < $1.startDate }) {
			for day in dayBlurbs {
//				Text("\(events.filter({$0.published == true && $0. == day}).count)")
				dailyBlock(events.filter({ $0.published == true }), dayNumber: day.0, blurb: day.1)
			}
		}
		Divider()
		musicEmbed(teaserText: "Care to get in the spirit with some reunions music?")
		
	}
}
