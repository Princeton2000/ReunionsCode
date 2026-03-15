//
//  Notes.swift
//  Princeton2000
//
//  Migrated to new Ignite API
//

import Foundation
import Ignite

struct Notes: StaticPage {
    @Environment(\.articles) var articles

    var title = "Class Notes"

    var body: some HTML {
        Section {
            for content in articles.typed("notes").sorted(by: { $0.date > $1.date }) {
                Section {
                    Card {
                        Group {
                            if let videoID = content.metadata["vimeo"] as? String {
                                if let videoIDInt = Int(videoID) {
                                    Embed(vimeoID: videoIDInt, title: content.title)
                                        .aspectRatio(.r16x9)
                                }
                            } else if let youTubeID = content.metadata["youtube"] as? String {
                                Embed(youTubeID: youTubeID, title: content.title)
                                    .aspectRatio(.r16x9)
                            } else if let genericURL = content.metadata["url"] as? String {
                                Embed(title: content.title, url: genericURL)
                                    .aspectRatio(.r16x9)
                            } else if let image = content.image {
                                Image(image, description: content.description)
                                    .accessibilityLabel(content.tags?.filter { $0 != "Class Notes" }.joined(separator: ", ") ?? "")
                                    .resizable()
                            }
                        }
                        .style(.borderRadius, "5px")
                        .style(.width, "100%")
                        .style(.height, "60%")
                        .style(.maxHeight, "418px")
                        .style(.objectFit, "cover")
                        .style(.objectPosition, "100% 56%")

                        Section {
                            Spacer()
                            Divider()
                            Link(content.metadata["title"] as? String ?? content.title, target: content.metadata["link"] as? String ?? "")
                                .target(.newWindow)
                                .relationship(.noOpener, .noReferrer)
                        }
                    }
                    .contentPosition(.top)
                    .frame(height: .percent(97.5%))
                    .margin(.bottom)
                }
                .width(3)
            }
        }
        .class("row")
    }
}
