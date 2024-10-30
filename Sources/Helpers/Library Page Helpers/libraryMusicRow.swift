//
//  libraryMusicRow.swift
//  IgniteStarter
//
//  Created by Justin Purnell on 9/5/24.
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

func spotifyElement(_ libraryEntry: LibraryEntry) -> String {
	return idElement(libraryEntry, prefix: "Spotify")
}

func amazonElement(_ libraryEntry: LibraryEntry) -> String {
	return idElement(libraryEntry, prefix: "Amazon Music")
}

func libraryMusicRow(_ libraryEntry: LibraryEntry) -> Row {
	let row =
	Row {
		Column {
			Group {
				Text(libraryEntry.title ?? "").font(.title2).fontWeight(.semibold)
				Section {
					Section {
						Text {
							Button("ⓧ") {
								if libraryEntry.links.contains(where: {$0.source == .appleMusic && $0.url != nil }) {
									HideElement(appleMusicElement(libraryEntry))
								}
								if libraryEntry.links.contains(where: {$0.source == .spotify && $0.url != nil }) {
									HideElement(spotifyElement(libraryEntry))
								}
								if libraryEntry.links.contains(where: {$0.source == .amazonMusic && $0.url != nil }) {
									HideElement(amazonElement(libraryEntry))
								}
								HideElement(idElement(libraryEntry))
							}
						}
					}.id(idElement(libraryEntry))
						.horizontalAlignment(.trailing)
				}
				
				Group {
					Section {
						for link in libraryEntry.links.filter({$0.source == .appleMusic && $0.url != nil || $0.source == .spotify && $0.url != nil || $0.source == .amazonMusic && $0.url != nil }) {
							if link.source == .appleMusic {
								Embed(title: "\(libraryEntry.title ?? "")", url: appleMusicEmbed(sharingURL: libraryEntry.links.first(where: {$0.source == .appleMusic})!.url!))
									.aspectRatio(.r4x3)
									.frame(height: 450)
									.padding(.top, "0px")
									.id(appleMusicElement(libraryEntry))
							}
							if link.source == .spotify {
								Embed(title: "\(libraryEntry.title ?? "")",
									  url: spotifyEmbed(sharingURL: libraryEntry.links.first(where: {$0.source == .spotify})!.url!))
								.aspectRatio(.r21x9)
								.frame(height: 450)
								.padding(.top, "0px")
								.hidden(libraryEntry.links.contains(where: {$0.source == .appleMusic && $0.url != nil }))
								.id(spotifyElement(libraryEntry))
							}
							
							if link.source == .amazonMusic {
								Embed(title: "\(libraryEntry.title ?? "")",
									  url: amazonEmbed(sharingURL: libraryEntry.links.first(where: {$0.source == .amazonMusic})!.url!))
								.aspectRatio(.r21x9)
								.frame(height: 450)
								.padding(.top, "0px")
								.hidden(libraryEntry.links.contains(where: {$0.source == .appleMusic && $0.url != nil || $0.source == .spotify && $0.url != nil}))
								.id(amazonElement(libraryEntry))
							}
						}
					}.columns(.max)
//					}.padding(.vertical)
					
					Group {
						for link in libraryEntry.links.filter({$0.url != nil }) {
							if link.source == .appleMusic {
								Image("/images/library/apple_music_logo.svg", description: "Listen to \(libraryEntry.title ?? "") by \(libraryEntry.classmate.firstName) \(libraryEntry.classmate.lastName) via Apple Music").resizable().frame(height: 20).onClick {
										ShowElement(appleMusicElement(libraryEntry))
										ShowElement(idElement(libraryEntry))
										if libraryEntry.links.contains(where: {$0.source == .spotify && $0.url != nil }) {
											HideElement(spotifyElement(libraryEntry))
										}
									if libraryEntry.links.contains(where: {$0.source == .amazonMusic && $0.url != nil }) {
										HideElement(amazonElement(libraryEntry))
										}
									}
									.opacity(1.0)
								.horizontalAlignment(.center)
								.padding(.horizontal)
							}
							if link.source == .spotify {
								Image("/images/library/Spotify_logo_with_text.svg", description: "Listen to \(libraryEntry.title ?? "") by \(libraryEntry.classmate.firstName) \(libraryEntry.classmate.lastName) via Spotify").resizable().frame(height: 20).onClick {
										ShowElement(spotifyElement(libraryEntry))
										ShowElement(idElement(libraryEntry))
										if libraryEntry.links.contains(where: {$0.source == .appleMusic && $0.url != nil }) {
											HideElement(appleMusicElement(libraryEntry))
										}
									if libraryEntry.links.contains(where: {$0.source == .amazonMusic && $0.url != nil }) {
										HideElement(amazonElement(libraryEntry))
										}
									}
									.opacity(1.0)
								.horizontalAlignment(.center)
								.padding(.horizontal)
							}
							if link.source == .amazonMusic {
								Image("/images/library/AmazonMusicLogo.svg", description: "Listen to \(libraryEntry.title ?? "") by \(libraryEntry.classmate.firstName) \(libraryEntry.classmate.lastName) via Amazon Music").resizable().frame(height: 20).onClick {
									ShowElement(amazonElement(libraryEntry))
										ShowElement(idElement(libraryEntry))
										if libraryEntry.links.contains(where: {$0.source == .appleMusic && $0.url != nil }) {
											HideElement(appleMusicElement(libraryEntry))
										}
									if libraryEntry.links.contains(where: {$0.source == .spotify && $0.url != nil }) {
										HideElement(spotifyElement(libraryEntry))
									}
									}
									.opacity(1.0)
								.horizontalAlignment(.center)
								.padding(.horizontal)
							}
						}
					}.padding(.vertical)
				}
				
			}
		}.columnSpan(.max)
	}
	return row
}
