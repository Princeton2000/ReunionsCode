//
//  LibraryHelpers.swift
//  Princeton2000
//
//  Library row display helpers
//

import Foundation
import Ignite

func idElement(_ libraryEntry: LibraryEntry, prefix: String = "close") -> String {
    let punctuation = CharacterSet.punctuationCharacters
    return "\(prefix) \(libraryEntry.title ?? "")".components(separatedBy: punctuation).joined()
}

func appleMusicElement(_ libraryEntry: LibraryEntry) -> String {
    return idElement(libraryEntry, prefix: "Apple Music")
}

func bandcampElement(_ libraryEntry: LibraryEntry) -> String {
    return idElement(libraryEntry, prefix: "Bandcamp")
}

func spotifyElement(_ libraryEntry: LibraryEntry) -> String {
    return idElement(libraryEntry, prefix: "Spotify")
}

func amazonElement(_ libraryEntry: LibraryEntry) -> String {
    return idElement(libraryEntry, prefix: "Amazon Music")
}

func linksWithUrlsFor(_ entry: LibraryEntry) -> [LibraryLink] {
    entry.links.filter { $0.url != nil }
}

@MainActor
func libraryRow(_ libraryEntry: LibraryEntry, includeDivider: Bool = true) -> some HTML {
    let linksWithUrls = linksWithUrlsFor(libraryEntry)

    return Section {
        Image(libraryEntry.image ?? "", description: libraryEntry.title)
            .resizable()
            .frame(minWidth: 100, maxWidth: 300, minHeight: 150, height: 300)
            .hint(text: libraryEntry.title ?? "")

        Group {
            Text(libraryEntry.title ?? "")
                .font(.title2)
                .fontWeight(.semibold)
            Text(libraryEntry.description?.replacingOccurrences(of: "\n", with: "<br>") ?? "")

            for link in linksWithUrls {
                if link.source == .vimeo {
                    Accordion {
                        Item("Watch Here") {
                            Embed(vimeoID: Int((link.url?.replacingOccurrences(of: "https://vimeo.com/", with: ""))!)!, title: "\(libraryEntry.title ?? "")")
                                .aspectRatio(.r16x9)
                                .padding(.top, 450)
                            Spacer()
                        }
                    }
                    .padding(.vertical, 10)
                } else if link.source == .youtube {
                    Accordion {
                        Item("Watch Here") {
                            Embed(youTubeID: (link.url?.replacingOccurrences(of: "https://www.youtube.com/watch?v=", with: ""))!, title: "\(libraryEntry.title ?? "")")
                                .aspectRatio(.r16x9)
                                .padding(.top, 450)
                            Spacer()
                        }
                    }
                    .padding(.vertical, 10)
                }
            }
        }

        Group {
            for link in linksWithUrls {
                Link(
                    Image(libraryLinkList.first(where: { $0.source == link.source })!.logoImage, description: "Find \(libraryEntry.title ?? "") by \(libraryEntry.classmate.firstName) \(libraryEntry.classmate.lastName) on \(link.source.rawValue)")
                        .resizable()
                        .frame(maxWidth: 100)
                        .padding(.trailing)
                        .opacity(0.75),
                    target: link.url ?? "#"
                )
                .target(.newWindow)
                .relationship(.noOpener, .noReferrer)
                .id("\(libraryEntry.title ?? "") at \(link.source.rawValue)")
            }
            if includeDivider {
                Divider()
            } else {
                Spacer()
            }
        }
    }
}

func musicStreamingLinks(_ libraryEntry: LibraryEntry) -> [LibraryLink] {
    libraryEntry.links.filter { link in
        (link.source == .appleMusic || link.source == .spotify || link.source == .amazonMusic) && link.url != nil
    }
}

func linksWithUrl(_ libraryEntry: LibraryEntry) -> [LibraryLink] {
    libraryEntry.links.filter { $0.url != nil }
}

@MainActor
func streamingEmbed(for link: LibraryLink, entry: LibraryEntry) -> some HTML {
    Group {
        if link.source == .appleMusic, let url = entry.links.first(where: { $0.source == .appleMusic })?.url {
            Embed(title: entry.title ?? "", url: appleMusicEmbed(sharingURL: url))
                .aspectRatio(.r4x3)
                .frame(height: 450)
                .padding(.top, 0)
                .id(appleMusicElement(entry))
        }
        if link.source == .spotify, let url = entry.links.first(where: { $0.source == .spotify })?.url {
            Embed(title: entry.title ?? "", url: spotifyEmbed(sharingURL: url))
                .aspectRatio(.r21x9)
                .frame(height: 450)
                .padding(.top, 0)
                .hidden(entry.links.contains(where: { $0.source == .appleMusic && $0.url != nil }))
                .id(spotifyElement(entry))
        }
        if link.source == .amazonMusic, let url = entry.links.first(where: { $0.source == .amazonMusic })?.url {
            Embed(title: entry.title ?? "", url: amazonEmbed(sharingURL: url))
                .aspectRatio(.r21x9)
                .frame(height: 450)
                .padding(.top, 0)
                .hidden(entry.links.contains(where: { $0.source == .appleMusic && $0.url != nil || $0.source == .spotify && $0.url != nil }))
                .id(amazonElement(entry))
        }
    }
}

@MainActor
func linkButton(for link: LibraryLink, entry: LibraryEntry) -> some HTML {
    Group {
        if link.source == .bandcamp {
            Link(
                Image("/images/library/bandcamp_logo.svg", description: "Buy \(entry.title ?? "") by \(entry.classmate.firstName) \(entry.classmate.lastName) via Bandcamp")
                    .resizable()
                    .frame(maxWidth: 100)
                    .padding(.trailing)
                    .opacity(0.75),
                target: link.url ?? "#"
            )
            .target(.newWindow)
            .relationship(.noOpener, .noReferrer)
            .id("\(entry.title ?? "") at \(link.source.rawValue)")
        }
        if link.source == .appleMusic {
            Image("/images/library/apple_music_logo.svg", description: "Listen to \(entry.title ?? "") by \(entry.classmate.firstName) \(entry.classmate.lastName) via Apple Music")
                .resizable()
                .frame(height: 20)
                .onClick {
                    ShowElement(appleMusicElement(entry))
                    ShowElement(idElement(entry))
                    if entry.links.contains(where: { $0.source == .spotify && $0.url != nil }) {
                        HideElement(spotifyElement(entry))
                    }
                    if entry.links.contains(where: { $0.source == .amazonMusic && $0.url != nil }) {
                        HideElement(amazonElement(entry))
                    }
                }
                .opacity(1.0)
                .horizontalAlignment(.center)
                .padding(.horizontal)
        }
        if link.source == .spotify {
            Image("/images/library/Spotify_logo_with_text.svg", description: "Listen to \(entry.title ?? "") by \(entry.classmate.firstName) \(entry.classmate.lastName) via Spotify")
                .resizable()
                .frame(height: 20)
                .onClick {
                    ShowElement(spotifyElement(entry))
                    ShowElement(idElement(entry))
                    if entry.links.contains(where: { $0.source == .appleMusic && $0.url != nil }) {
                        HideElement(appleMusicElement(entry))
                    }
                    if entry.links.contains(where: { $0.source == .amazonMusic && $0.url != nil }) {
                        HideElement(amazonElement(entry))
                    }
                }
                .opacity(1.0)
                .horizontalAlignment(.center)
                .padding(.horizontal)
        }
        if link.source == .amazonMusic {
            Image("/images/library/AmazonMusicLogo.svg", description: "Listen to \(entry.title ?? "") by \(entry.classmate.firstName) \(entry.classmate.lastName) via Amazon Music")
                .resizable()
                .frame(height: 20)
                .onClick {
                    ShowElement(amazonElement(entry))
                    ShowElement(idElement(entry))
                    if entry.links.contains(where: { $0.source == .appleMusic && $0.url != nil }) {
                        HideElement(appleMusicElement(entry))
                    }
                    if entry.links.contains(where: { $0.source == .spotify && $0.url != nil }) {
                        HideElement(spotifyElement(entry))
                    }
                }
                .opacity(1.0)
                .horizontalAlignment(.center)
                .padding(.horizontal)
        }
    }
}

@MainActor
func libraryMusicRow(_ libraryEntry: LibraryEntry) -> some HTML {
    let streamingLinks = musicStreamingLinks(libraryEntry)
    let allLinks = linksWithUrl(libraryEntry)

    return Row {
        Column {
            Group {
                Text(libraryEntry.title ?? "")
                    .font(.title2)
                    .fontWeight(.semibold)

                Section {
                    Section {
                        Text {
                            Button("ⓧ") {
                                if libraryEntry.links.contains(where: { $0.source == .appleMusic && $0.url != nil }) {
                                    HideElement(appleMusicElement(libraryEntry))
                                }
                                if libraryEntry.links.contains(where: { $0.source == .spotify && $0.url != nil }) {
                                    HideElement(spotifyElement(libraryEntry))
                                }
                                if libraryEntry.links.contains(where: { $0.source == .amazonMusic && $0.url != nil }) {
                                    HideElement(amazonElement(libraryEntry))
                                }
                                HideElement(idElement(libraryEntry))
                            }
                        }
                    }
                    .id(idElement(libraryEntry))
                    .horizontalAlignment(.trailing)
                }

                Group {
                    Section {
                        for link in streamingLinks {
                            streamingEmbed(for: link, entry: libraryEntry)
                        }
                    }

                    Group {
                        for link in allLinks {
                            linkButton(for: link, entry: libraryEntry)
                        }
                    }
                    .padding(.vertical)
                }
            }
        }
        .columnSpan(.max)
    }
}
