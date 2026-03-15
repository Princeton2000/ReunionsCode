//
//  Kids.swift
//  Princeton2000
//
//  Kids page
//

import Foundation
import Ignite

struct Kids: StaticPage {
    var title = "Kids"
    var description: String = "What you need to know about our Kids' Schedule."
    var image: String? = "/images/logos/P2000_25th_Lounging_Tiger.svg"
    let kidsGuideSlides = [1, 2, 3, 4, 5, 6]
        .map({ "/images/kidsGuide/kidsGuide.\(String(format: "%03d", $0)).png" })

    var body: some HTML {
        Group {
            Text(markdown: "We've planned a host of activities at our Headquarters site for families with kids, including a bouncy slide, a photo booth with props, retro [movies](../schedule-movies/), and assorted games.")
            Text(markdown: "**Note:** *We are not legally allowed to provide child care onsite.*")

            Text(markdown: "Check out the Kids' Schedule [here:](../schedule-kids/)")
        }
        .padding(.horizontal, 5)

        Embed(title: "Kids' Guide to Reunions", url: "/pdfs/reunionsKidsGuide.pdf")
            .aspectRatio(.r4x3)

        Divider()

        Group {
            Text("Register for Tiger Camp")
                .font(.title1)
            Text(markdown: "Princeton has partnered with **[YWCA Princeton](https://www.ywcaprinceton.org)** to offer its traditional **\"Tiger Camp\"** childcare during Reunions from **Friday, May 23** to **Saturday, May 24**.")
            Text(markdown: "Registration for kids 3 months to 12 years is now open!")
            Link("Tiger Camp Information", target: "https://www.ywcaprinceton.org/tiger-reunion-childcare")
                .linkStyle(.button)
                .buttonSize(.large)
                .role(.dark)
                .padding()
            Group {
                Image("/images/photos/IMG_0464.jpeg.webp", description: "Tiger Cubs play Jenga at Tiger Camp")
                    .resizable()
                    .padding(.vertical, 20)
            }
        }
        .horizontalAlignment(.center)
        .padding(.horizontal, 20)
    }
}
