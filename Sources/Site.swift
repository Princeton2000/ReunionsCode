//
//  Site.swift
//  Princeton2000
//
//  Migrated to new Ignite API
//

import Foundation
import Ignite

@main
struct IgniteWebsite {
    static func main() async {
        var site = Princeton2000()
        do {
            try await site.publish(buildDirectoryPath: "docs")
        } catch {
            print(error.localizedDescription)
        }
    }
}

// MARK: - Deployment Configuration

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

// MARK: - Site Definition

struct Princeton2000: Site {
    var name = Reunion.upcoming.yearLabel
    var titleSuffix = " | Princeton Class of 2000"
    var description: String? = "Bid Every Care Withdraw: Princeton's Class of 2000 celebrates its \(Reunion.upcoming.title), \(Reunion.upcoming.dateRange)"

    var language: Language = .english
    var url = URL(string: deployment().rawValue)!
    var builtInIconsEnabled: BootstrapOptions = .localBootstrap
    var author = "Princeton 2000"

    // Feed configuration
    var feedConfiguration: FeedConfiguration? = FeedConfiguration(
        mode: .full,
        contentCount: 20,
        path: "/feed.rss",
        image: FeedConfiguration.FeedImage(
            url: "https://reunions.princeton2000.org/images/logosP2000_25th_TigerHead_BECW_60x60.png",
            width: 144,
            height: 144
        ),
        contentTypes: ["letters"]
    )

    // Page configuration
    var homePage = Home()
    var tagPage = EmptyTagPage()
    var layout = MainLayout()

    // Themes (new API - separate from layout)
    var lightTheme: (any Theme)? = PrincetonLightTheme()
    var darkTheme: (any Theme)? = PrincetonDarkTheme()

    // Static pages (renamed from 'pages')
    var staticPages: [any StaticPage] {
//        News()
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
        Officers()
        Leadership()
        Crew()
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
        ClassHome()
        Privacy()
        FAQ()
    }

    // Article pages (renamed from 'layouts', type changed from ContentPage)
    var articlePages: [any ArticlePage] {
        Story()
        Email()
        HonoraryProfile()
    }
}

// MARK: - Tags Page

struct Tags: TagPage {
    var body: some HTML {
        Text("Content tagged with: ")
            .font(.title1)
        // Tag content will be rendered here
    }
}
