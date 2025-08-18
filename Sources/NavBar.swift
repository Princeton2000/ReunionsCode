//
//  NavBar.swift
//  IgniteStarter
//
//  Created by Justin Purnell on 7/8/24.
//

import Foundation
import Ignite

enum FontFamily: String, Codable {
	case princetonMonticello = "princeton_monticello"
	case tayLennon = "TAYLennonRegular"
	case libreFranklin = "Libre Franklin"
	case franklinGothic = "franklin_gothic"
}

public struct NavBar: Component {
	public init() { }
	
	func logo(_ image: String = "/images/Logo_2000Reunion_TIGER_Color_60px.png", altText: String = "Princeton 2000 Tiger Logo", _ width: Int = 72, _ height: Int = 72, destination: String = "/") -> String  {
		return "<a href=\"\\\" class=\"navbar-brand\" aria-label=\"home\" \" alt=\"\(altText)\"><img src=\"\(image)\" \" alt=\"\(altText)\" aria-label=\"\(altText)\" class=\"img-fluid mx-auto\" style=\"width: \(width)px; height: \(height)px\"></a>"
	}
	func header(_ message: String = "PRINCETON 2000", _ fontFamily: FontFamily = .princetonMonticello) -> String {
		return "<a href=\"\\\" class=\"navbar-brand\"><h3 style=\"font-family: \(fontFamily.rawValue); font-size: calc(1.2rem + .5vw); color: #EE7F2D; line-height: 2rem; margin-bottom: 0rem; text-align: center; class=\"text-center mx-auto\">\(message)</h2>"
	}
	func kicker(_ message: String = "BID EVERY CARE WITHDRAW", _ fontFamily: FontFamily = .princetonMonticello) -> String {
		"<h6 style=\"font-family: \(fontFamily.rawValue); font-size: calc(0.55rem + 0.5vw); color: var(--bs-heading-color); line-height: 1rem; padding: 0em; margin-bottom: 0rem; letter-spacing: .10rem; class=\"text-center mx-auto\">\(message)</h6></a>"
	}
	
	func navBarString(logo: String, _ header: String, _ kicker: String) -> String {
		return """
   \(logo)
   \(header)
   \(kicker)
"""
	}

	public func body(context: PublishingContext) -> [any PageElement] {
		NavigationBar(logo: navBarString(logo:
											logo("/images/logos/P2000_25th_TigerHead_BECW.svg", 100, 100),
										 header("Princeton 2000", .tayLennon),
										 kicker("Bid Every Care Withdraw", .tayLennon))
		) {
			Link(Text("Notes").margin(.bottom, 0).foregroundStyle(.princetonOrange), target: Notes())
			Link(Text("Library").margin(.bottom, 0).foregroundStyle(.princetonOrange), target: Library())
			Link(Text("Dues").margin(.bottom, 0).foregroundStyle(.princetonOrange), target: Dues())
			Link(Text("Donate").margin(.bottom, 0).foregroundStyle(.princetonOrange), target: "https://donate.stripe.com/7sI5n6bgzbsV06seUU")
//			Link(Text("Merch").foregroundStyle(.princetonOrange), target: Gear())
			Link(Text("Officers").foregroundStyle(.princetonOrange), target: Officers())
			Link(Text("Constitution").margin(.bottom, 0).foregroundStyle(.princetonOrange), target: Constitution())
			Link(Text("AG").margin(.bottom, 0).foregroundStyle(.princetonOrange), target: CommitteeAG())
			Link(Text("Honoraries").margin(.bottom, 0).foregroundStyle(.princetonOrange), target: HonoraryClassmates())
			Dropdown("Reunions 2025"){
				Link(Text("Registration").foregroundStyle(.princetonOrange), target: Registration())
				Link(Text("Housing").foregroundStyle(.princetonOrange), target:  Housing())
				Link(Text("Schedule").foregroundStyle(.princetonOrange), target: Schedule())
				Link(Text("Kids").foregroundStyle(.princetonOrange), target: Kids())
				Link(Text("FAQ").foregroundStyle(.princetonOrange), target: faq())
				Link(Text("Theme").foregroundStyle(.princetonOrange), target: BidEveryCareWithdraw())
				Link(Text("Jacket").foregroundStyle(.princetonOrange), target: Jacket())
	//			Link(Text("Merch").foregroundStyle(.princetonOrange), target: "https://princeton.reunioniq.com/shop/classof00")
				Link(Text("Service").foregroundStyle(.princetonOrange), target: "https://www.letherplay.org/princeton-reunions-2025")
				Link(Text("Reunions Committee").margin(.bottom, 0).foregroundStyle(.princetonOrange), target: CommitteeReunions())
				Link(Text("Crew").foregroundStyle(.princetonOrange), target: Crew())
			}
			.role(.secondary).dropdownSize(.large)
//			Dropdown("Satellites") {
//				Link(Text("1998").foregroundStyle(.princetonOrange), target: "https://www.princeton98.org")
//				Link(Text("1999").foregroundStyle(.princetonOrange), target: "https://princeton99.com")
//				Link(Text("2001").foregroundStyle(.princetonOrange), target: "https://www.tigers01.org")
//				Link(Text("2002").foregroundStyle(.princetonOrange), target: "https://princeton2002.com")
//			}
//			Link(Text("Notes").foregroundStyle(.princetonOrange), target: Notes())
//			Link(Text("Library").foregroundStyle(.princetonOrange), target: Library())
//			Link(Text("Dues").foregroundStyle(.princetonOrange), target: Dues())
//			Link(Text("Constitution").margin(.bottom, 0).foregroundStyle(.princetonOrange), target: Constitution())
//			Link(Text("P-rade").foregroundStyle(.princetonOrange), target: Prade())
		}
		.navigationItemAlignment(.trailing)
		.navigationBarStyle(.light)
	}
}
