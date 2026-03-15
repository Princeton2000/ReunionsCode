//
//  NavBar.swift
//  Princeton2000
//
//  Navigation bar component migrated to new Ignite API
//

import Foundation
import Ignite

enum FontFamily: String, Codable {
    case princetonMonticello = "princeton_monticello"
    case tayLennon = "TAYLennonRegular"
    case libreFranklin = "Libre Franklin"
    case franklinGothic = "franklin_gothic"
}

struct NavBar: HTML {
    func logo(
        _ image: String = "/images/Logo_2000Reunion_TIGER_Color_60px.png",
        altText: String = "Princeton 2000 Tiger Logo",
        _ width: Int = 72,
        _ height: Int = 72
    ) -> String {
        return "<img src=\"\(image)\" alt=\"\(altText)\" aria-label=\"\(altText)\" class=\"img-fluid mx-auto\" style=\"width: \(width)px; height: \(height)px\">"
    }

    func header(
        _ message: String = "PRINCETON 2000",
        _ fontFamily: FontFamily = .princetonMonticello
    ) -> String {
        return "<h3 style=\"font-family: \(fontFamily.rawValue); font-size: calc(1.2rem + .5vw); color: #EE7F2D; line-height: 2rem; margin-bottom: 0rem; text-align: center;\">\(message)</h3>"
    }

    func kicker(
        _ message: String = "BID EVERY CARE WITHDRAW",
        _ fontFamily: FontFamily = .princetonMonticello
    ) -> String {
        "<h6 style=\"font-family: \(fontFamily.rawValue); font-size: calc(0.55rem + 0.5vw); color: var(--bs-body-color); line-height: 1rem; padding: 0em; margin-bottom: 0rem; letter-spacing: .10rem;\">\(message)</h6>"
    }

    func navBarString(logo: String, _ header: String, _ kicker: String) -> String {
        return """
   \(logo)
   <div style="text-align: center;">\(header)\(kicker)</div>
"""
    }

    var body: some HTML {
        NavigationBar(
            logo: navBarString(
                logo: logo("/images/logos/P2000_25th_TigerHead_BECW.svg", altText: "Princeton 2000 Tiger Logo", 100, 100),
                header("Princeton 2000", .tayLennon),
                kicker("Bid Every Care Withdraw", .tayLennon)
            )
        ) {
            Link("Jacket", target: "https://tinyurl.com/2000jacket")
            Link("Store", target: "https://tinyurl.com/2000store")
            Link("Notes", target: Notes())
            Link("Library", target: Library())
            Link("Dues", target: Dues())
            Link("Officers", target: Officers())
            Link("Constitution", target: Constitution())
            Link("AG", target: CommitteeAG())
            Link("Honoraries", target: HonoraryClassmates())
            Dropdown("Reunions 2025") {
                Link("Registration", target: Registration())
                Link("Housing", target: Housing())
                Link("Schedule", target: Schedule())
                Link("Kids", target: Kids())
                Link("Theme", target: BidEveryCareWithdraw())
                Link("Jacket", target: Jacket())
                Link("Service", target: "https://www.letherplay.org/princeton-reunions-2025")
                Link("Reunions Committee", target: CommitteeReunions())
                Link("Crew", target: Crew())
            }
            .role(.secondary)
            .dropdownSize(.large)
        }
        .navigationItemAlignment(.trailing)
    }
}
