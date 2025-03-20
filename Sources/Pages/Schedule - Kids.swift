//
//  Housing.swift
//
//
//  Created by Justin Purnell on 7/8/24.
//

import Foundation
import Ignite

struct ScheduleKids: StaticPage {
	var title = "Kid's Schedule"
//	var events: [Event] { let decoder = JSONDecoder(); let data = try! Data(contentsOf: URL(fileURLWithPath: "/Users/jpurnell/Dropbox/Computer/Development/Swift/Princeton/Website/ExampleSite/Resources/events_real.json"));
	var events: [Event] { let decoder = JSONDecoder(); let data = try! Data(contentsOf: URL(fileURLWithPath: "/Users/jpurnell/Dropbox/Computer/Development/Swift/Princeton/Website/ExampleSite/Resources/events.json"));
	let events = try! decoder.decode([Event].self, from: data); return events.sorted(by: {$0.startDate < $1.startDate})}
	typealias dayData = (Int, String)
	let dayBlurbs: [dayData] = [(5, "Come back and see what’s changed! We’ll have family activities and a chance for people to ease back into life on campus at our headquarters in Whitman College."), (6, "We will host breakfast, lunch, and family activities at headquarters, and we will offer a community service event at HQ in the afternoon. Move on over to Jadwin Gym for our Class Cocktail Reception (5-6 pm) and Class Dinner (6-8 pm). Then party down with TBA and TBA in the evening."), (7, "Join us for a special class brunch and our class photo, then show off your new jacket and flair in the P-rade!\nWe have added Alumni Faculty Forums with panelists from the Class of 2000 to our schedule."), (1, "Closing time, to quote Semisonic.\nGrab some breakfast as you head out with your memories and begin your Reunions recovery.")]
	let activityFilter: [EventType] = [.movie, .childrensActivity, .communityService, .classFamily, .foodDrink]
	
	func body(context: PublishingContext) -> [BlockElement] {
		Alert {
			Text(markdown: "**PLEASE NOTE:** This is just an indicative schedule, based off the '98s and '99s recent weekends. Come back frequently as we fill in details!").fontWeight(.semibold).horizontalAlignment(.center)
		}.role(.info)
		for day in dayBlurbs {
			dailyBlock(events.filter({activityFilter.contains($0.type) && $0.published == true }), dayNumber: day.0, blurb: day.1)
		}
		Divider()
		musicEmbed(teaserText: "Kids, you're going to hear this stuff all weekend, might as well learn these songs now.")
	}
}
