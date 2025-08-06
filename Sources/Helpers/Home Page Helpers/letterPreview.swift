//
//  letterPreview.swift
//  IgniteStarter
//
//  Created by Justin Purnell on 8/6/25.
//

import Ignite

func letterPreviewRow(_ content: Content) -> Row {
	Row {
		if let image = content.image {
			Image("\(image)", description: "\(content.tags.filter({$0 == "Class Notes"}).map({$0}).joined(separator: ", "))").frame(width: 100, minWidth: 100, maxWidth: 100, alignment: .leading)
		}
		Group {
			Text {
				Link("\(content.metadata["title"] as! String)",
					 target: content.path)
				.target(.newWindow)
				.relationship(.noOpener, .noReferrer)
				"<br>\(formatDate(content.metadata["lastModified"] as? String ?? "", .short, .short))</br>"
			}
			.fontWeight(.medium)
		}
		
	}
}


