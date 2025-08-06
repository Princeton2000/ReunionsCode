//
//  notePreviewRow.swift
//  IgniteStarter
//
//  Created by Justin Purnell on 8/6/25.
//

import Ignite

func notePreviewRow(_ content: Content) -> Row {
	Row {
		if let image = content.image {
			Image("\(image)", description: "\(content.tags.filter({$0 != "Class Notes"}).map({$0}).joined(separator: ", "))").frame(width: 100, minWidth: 100, maxWidth: 100, alignment: .leading)
		}
		Group {
			Text {
				Link("\(content.metadata["title"] as! String)",
					 target: content.metadata["link"] as? String ?? content.path)
				.target(.newWindow)
				.relationship(.noOpener, .noReferrer)
			}.fontWeight(.semibold)
		}
	}
}
