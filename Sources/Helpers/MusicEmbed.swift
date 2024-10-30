	//
	//  MusicEmbed.swift
	//  IgniteStarter
	//
	//  Created by Justin Purnell on 8/22/24.
	//

import Ignite

func musicEmbed(teaserText: String) -> Accordion {
	Accordion {
		Item("\(teaserText)") {
			Group {
//				Image("/images/library/apple_music_logo.svg", description: "Listen to jams via Apple Music").resizable().frame(height: 20).onClick {
//					ShowElement("Apple Music Pop")
//					HideElement("Spotify Pop")
//					HideElement("Apple Music WPRB")
//					HideElement("Spotify WPRB")
//				}
//				.horizontalAlignment(.center)
//				.width(1)
//				.padding(.horizontal)
				
					// MARK: -- Apple Music SVG doesn't appear correctly in Dark Mode in Safari because of how Bootstrap triggers dark mode. This HTML snippet forces the correct version.
				Include("apple_music_logo.html")
				Image("/images/library/Spotify_logo_with_text.svg", description: "Listen to jams via Spotify").resizable().frame(height: 20).onClick  {
					HideElement("Apple Music Pop")
					ShowElement("Spotify Pop")
					HideElement("Apple Music WPRB")
					HideElement("Spotify WPRB")
				}
				.horizontalAlignment(.center)
				.width(1)
				.padding(.horizontal)
			}
			.padding(.horizontal)
			.padding(.vertical, 20)
			.horizontalAlignment(.leading)
			
			Section{
				Embed(title: "Cloister Jams", url: "https://embed.music.apple.com/us/playlist/90s-and-2000s-throwbacks-popstruck/pl.0715a79d72704d4783d43ab932a2828f").aspectRatio(.r4x3)
					//						Include("appleMusicEmbed.html")
			}
			.id("Apple Music Pop")
			
			Section{
				
				Embed(title: "Spotify Jams", url: "https://open.spotify.com/embed/playlist/6ueHEWo22uqlO81f3az06W?utm_source=generator&theme=0").aspectRatio(.r4x3)
					//						Include("spotifyEmbed.html")
			}
			.id("Spotify Pop")
			.hidden()
			Section {
				Embed(title: "WPRB", url: "https://embed.music.apple.com/us/playlist/last-show/pl.u-0xdmAtk1PoV").aspectRatio(.r4x3)
			}
			.id("Apple Music WPRB")
			.hidden()
			Section {
				Embed(title: "WPRB", url: "https://open.spotify.com/embed/playlist/3LJ331Qa1p4JEEw9LPK49d").aspectRatio(.r4x3)
			}
			.id("Spotify WPRB")
			.hidden()
		}
	}
}
