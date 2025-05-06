import Foundation
import Ignite

@main
struct IgniteWebsite {
	static func main() async {
		let site = Princeton2000()
		do {
			try await site.publish(buildDirectoryPath: "docs")
		} catch {
			print(error.localizedDescription)
		}
	}
}

public enum SiteLocation: String {
	case production = "https://reunions.princeton2000.org"
	case staging = "https://staging.princeton2000.org"
}

func siteLocation(_ site: SiteLocation) -> String {
	return site.rawValue
}

public func deployment() -> SiteLocation {
	return .production
}

struct Princeton2000: Site {
	var name = "Reunions 2025"
	var titleSuffix = " – Princeton 2000"
	var description = "Bid Every Care Withdraw: Princeton's Class of 2000 celebrates its 25th Reunion, May 22-25, 2025"
	
	var language: Locale.Language = .init(identifier: "en-US")
	var url = URL(string: deployment().rawValue)!
	var builtInIconsEnabled = true
	var robotsConfiguration = Robots()
	var feedConfiguration = RSS()
	var author = "Princeton 2000"

	var homePage = Home()
	var tagPage = Tags()
	var theme = MyTheme()
	
	var pages: [any StaticPage] {
		News()
		Library()
		Notes()
		Registration()
		Housing()
		Schedule()
		Kids()
		ScheduleKids()
		ScheduleMovies()
		CommitteeAG()
		CommitteeReunions()
//		Entertainment()
		Crew()
		faq()
		Jacket()
		JacketPreLaunch()
		Gear()
		Merch()
		Prade()
		TableVideo()
		BidEveryCareWithdraw()
		HonoraryClassmates()
		Colophon()
		Dues()
		Constitution()
	}
	
	var layouts: [any ContentPage] {
		Story()
		Email()
	}
}








