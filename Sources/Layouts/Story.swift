//
//  Story.swift
//  Princeton2000
//
//  ArticlePage for rendering content/story markdown files
//  Migrated from ContentPage to ArticlePage
//

import Foundation
import Ignite

struct Story: ArticlePage {
    var body: some HTML {
        // Title with optional link
        if let link = article.metadata["link"] as? String, !link.isEmpty {
            Link(article.metadata["question"] as? String ?? article.metadata["title"] as? String ?? article.title,
                 target: link)
                .font(.title1)
        } else {
            Text(article.metadata["question"] as? String ?? article.metadata["title"] as? String ?? article.title)
                .font(.title1)
        }

        // Featured image
        if let image = article.image {
            Image(image, description: article.imageDescription)
                .resizable()
                .cornerRadius(20)
                .frame(maxHeight: 300)
                .horizontalAlignment(.center)
        }

        // Tags
        if let tags = article.tags, !tags.isEmpty {
            Group {
                if let tagLinks = article.tagLinks() {
                    Text {
                        for link in tagLinks {
                            link
                        }
                    }
                    .font(.title6)
                }
            }
        }

        // Main content
        Text(article.text)

        // "Read more" link if external link exists
        if let link = article.metadata["link"] as? String, !link.isEmpty {
            Text {
                Link(target: link) {
                    "Read more..."
                }
            }
        }
    }
}
