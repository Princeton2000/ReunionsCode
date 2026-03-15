//
//  HomeHelpers.swift
//  Princeton2000
//
//  Home page helper functions
//

import Ignite

@MainActor
func letterPreviewRow(_ content: Article) -> Row {
    Row {
        if let image = content.image {
            Image("\(image)", description: "\(content.tags?.filter({ $0 == "Class Notes" }).map({ $0 }).joined(separator: ", ") ?? "")")
                .frame(minWidth: 100, width: 100, maxWidth: 100)
        }
        Group {
            Text {
                Link("\(content.metadata["title"] as? String ?? content.title)", target: content.path)
                    .target(.newWindow)
                    .relationship(.noOpener, .noReferrer)
                "<br>\(formatDate(content.lastModified, .short, .short))</br>"
            }
            .fontWeight(.medium)
        }
    }
}
