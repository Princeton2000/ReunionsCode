//
//  LibraryLink.swift
//  Princeton2000
//
//  Library link models and sources
//

import Foundation

public enum LinkSource: String, Codable {
    case bam = "BAM"
    case barnesAndNoble = "Barnes & Noble"
    case amazon = "Amazon"
    case appleBooks = "Apple Books"
    case bookshop = "Bookshop"
    case disneyPlus = "Disney Plus"
    case appleMusic = "Apple Music"
    case bandcamp = "Bandcamp"
    case spotify = "Spotify"
    case amazonMusic = "Amazon Music"
    case appleTV = "Apple TV"
    case paramountPlus = "Paramount Plus"
    case vimeo = "Vimeo"
    case youtube = "YouTube"
    case primeVideo = "Prime Video"
    case netflix = "Netflix"
}

public struct LibraryLink: Codable {
    let source: LinkSource
    let url: String?
}

public struct LibraryLinkImages: Codable {
    let source: LinkSource
    let logoImage: String
}

public let libraryLinkList: [LibraryLinkImages] = [
    LibraryLinkImages(source: .bam, logoImage: "/images/library/Books-A-Million_logo.svg"),
    LibraryLinkImages(source: .barnesAndNoble, logoImage: "/images/library/Barnes_&_Noble_logo.svg"),
    LibraryLinkImages(source: .amazon, logoImage: "/images/library/Amazon_logo.svg"),
    LibraryLinkImages(source: .appleBooks, logoImage: "/images/library/Apple_Books_logo.svg"),
    LibraryLinkImages(source: .bookshop, logoImage: "/images/library/bookshop.svg"),
    LibraryLinkImages(source: .disneyPlus, logoImage: "/images/library/Disney+_logo.svg"),
    LibraryLinkImages(source: .appleMusic, logoImage: "/images/library/apple_music_logo.svg"),
    LibraryLinkImages(source: .bandcamp, logoImage: "/images/library/bandcamp_logo.svg"),
    LibraryLinkImages(source: .spotify, logoImage: "/images/library/Spotify_logo_with_text.svg"),
    LibraryLinkImages(source: .amazonMusic, logoImage: "/images/library/AmazonMusicLogo.svg"),
    LibraryLinkImages(source: .appleTV, logoImage: "/images/library/Apple_TV_logo.svg"),
    LibraryLinkImages(source: .paramountPlus, logoImage: "/images/library/ParamountPlus_logo.svg"),
    LibraryLinkImages(source: .vimeo, logoImage: "/images/library/Vimeo_Logo.svg"),
    LibraryLinkImages(source: .youtube, logoImage: "/images/library/YouTube_Logo_2017.svg"),
    LibraryLinkImages(source: .primeVideo, logoImage: "/images/library/Amazon_Prime_Video_logo.svg"),
    LibraryLinkImages(source: .netflix, logoImage: "/images/library/netflix_logo.svg"),
]

// Music embed URL converters
func appleMusicEmbed(sharingURL: String) -> String {
    return sharingURL.replacingOccurrences(of: "music.apple.com", with: "embed.music.apple.com")
}

func spotifyEmbed(sharingURL: String) -> String {
    return sharingURL.replacingOccurrences(of: "open.spotify.com", with: "open.spotify.com/embed")
}

func amazonEmbed(sharingURL: String) -> String {
    if sharingURL.hasPrefix("https://music.amazon.com/albums/") {
        return sharingURL.replacingOccurrences(of: "music.amazon.com/albums/", with: "music.amazon.com/embed/").split(separator: "&").dropLast().joined(separator: "&")
    } else {
        return sharingURL.replacingOccurrences(of: "amazon.com/music/player/albums/", with: "music.amazon.com/embed/").split(separator: "&").dropLast().joined(separator: "&")
    }
}
