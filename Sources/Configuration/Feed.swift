//
//  File.swift
//  
//
//  Created by Justin Purnell on 7/23/24.
//

import Foundation
import Ignite

func RSS(mode: FeedConfiguration.ContentMode = .full, contentCount: Int = 20, path: String = "/feed.rss", image: FeedConfiguration.FeedImage = FeedConfiguration.FeedImage(url: "https://reunions.princeton2000.org/images/rss.png", width: 144, height: 152)) -> FeedConfiguration {
	
	return FeedConfiguration(mode: mode, contentCount: contentCount, path: path, image: image)
}
