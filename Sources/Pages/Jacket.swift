//
//  Jacket.swift
//  Princeton2000
//
//  Migrated to new Ignite API
//

import Foundation
import Ignite

struct Jacket: StaticPage {
    @Environment(\.articles) var articles

    var title = "Jacket"
    var description: String = "Learn about our incredible 25th jacket"
    var image: URL? = URL(string: "/images/jacket/P2000_jacket_sketch.png")

    let jacketTestSlides = [1, 2, 3, 4, 5, 9, 10, 23, 12, 13, 14, 19, 20]
        .map { "/images/jacket/testSlides/testSlides.\(String(format: "%03d", $0)).png" }

    var jacketFaqArticles: [Article] {
        articles.typed("faq")
            .filter { ($0.tags ?? []).contains("jacket") }
            .sorted(by: { ($0.tags?.first ?? "") < ($1.tags?.first ?? "") })
    }

    var body: some HTML {

        Embed(title: "Kids' Guide to Reunions", url: "/pdfs/styleGuide.pdf")
            .aspectRatio(.r16x9)

        Image("/images/jacket/P2000_jacket_sketch.png", description: "A seersucker-type jacket with wide orange stripes and small black accent stripes. The lining is cream, with the lyrics of Old Nassau, interrupted occasionally with a sketch of the Nassau Hall tiger in profile, and overlid with a large \"'00\" in Princeton Orange")
            .resizable()
            .width(12)
            .class("fade-in-image")

        Spacer()

        Text("Here it is! We're so pleased to share this sketch of our 25th Class Jacket.")
            .fontWeight(.bold)
            .horizontalAlignment(.center)

        Spacer()

        Text("How we got here")
            .class("tayLennon")
            .font(.title1)

        Group {
            for content in articles.typed("jacket_design") {
                Text(content.text)
            }
        }
        .padding(.horizontal, 20)

        Section {
            Carousel {
                for image in jacketTestSlides {
                    Slide(background: image) {
                    }
                }
            }
            .carouselStyle(.move)
        }

        Spacer()

        Text("Check out these 3-D Renderings!")
            .class("tayLennon")
            .font(.title1)

        Section {
            Embed(youTubeID: "Xyx9nDX94v8", title: "Jacket, feminine cut")
                .aspectRatio(.r4x3)
            Embed(youTubeID: "NPH60NzIDwA", title: "Jacket, masculine cut")
                .aspectRatio(.r4x3)
        }

        Spacer()

        Text("Our team made a how-to video on getting your measurements from an existing jacket.")

        Section {
            Embed(youTubeID: "OZ3EhH3GHaY", title: "Measuring your jacket")
                .aspectRatio(.r4x3)
        }

        Spacer()
        Divider()

        Accordion {
            for content in jacketFaqArticles {
                Item(content.metadata["question"] as? String ?? content.title) {
                    Text(markdown: content.text)
                }
            }
        }
    }
}
