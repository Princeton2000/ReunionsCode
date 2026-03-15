//
//  Email.swift
//  Princeton2000
//
//  ArticlePage for rendering email-style content
//  Migrated from ContentPage to ArticlePage
//

import Foundation
import Ignite

struct Email: ArticlePage {
    var body: some HTML {
        Group {
            // Title
            Text(article.metadata["title"] as? String ?? article.title)
                .font(.title1)

            // Date
            Text(formatDate(article.lastModified, .medium, .short))

            // Featured image
            if let image = article.image {
                Image(image, description: article.imageDescription)
                    .resizable()
                    .cornerRadius(10)
                    .horizontalAlignment(.center)
            }

            // Main content
            Text(article.text)
        }
        .frame(maxWidth: 900)
        .padding(.horizontal, 5)
    }
}
