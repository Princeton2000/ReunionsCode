//
//  musicLinks.swift
//  IgniteStarter
//
//  Created by Justin Purnell on 9/5/24.
//


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
