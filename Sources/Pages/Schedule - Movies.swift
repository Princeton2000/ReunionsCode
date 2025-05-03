//
//  Housing.swift
//
//
//  Created by Justin Purnell on 7/8/24.
//

import Foundation
import Ignite

struct ScheduleMovies: StaticPage {
	var title = "Movie Schedule"
	typealias dayData = (Int, String)
	let dayBlurbs: [dayData] = [(5, "Come back and see what’s changed! We’ll have family activities and a chance for people to ease back into life on campus at our headquarters in Whitman College."), (6, "We will host breakfast, lunch, and family activities at headquarters, and we will offer a community service event at HQ in the afternoon. Move on over to Jadwin Gym for our Class Cocktail Reception (5-6 pm) and Class Dinner (6-8 pm). Then party down with TBA and TBA in the evening."), (7, "Join us for a special class brunch and our class photo, then show off your new jacket and flair in the P-rade!\nWe have added Alumni Faculty Forums with panelists from the Class of 2000 to our schedule.")]
	let activityFilter: [EventType] = [.movie]
	
	func body(context: PublishingContext) -> [BlockElement] {
		if let events = context.decode(resource: "events.json", as: [Event].self)?.sorted(by: { $0.startDate < $1.startDate }) {
			for day in dayBlurbs {
				dailyBlock(events.filter({activityFilter.contains($0.type) && $0.published == true }), dayNumber: day.0, blurb: day.1)
			}
		}
	}
}
