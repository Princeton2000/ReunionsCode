//
//  HonoraryProfile.swift
//  Princeton2000
//
//  ArticlePage layout for honorary classmate profiles
//  Photo on the left, citation text on the right
//

import Foundation
import Ignite

struct HonoraryProfile: ArticlePage {
    var body: some HTML {
        Group {
            Text(article.metadata["title"] as? String ?? article.title)
                .font(.title1)

            Section {
                Section {
                    if let image = article.image {
                        Image(image, description: article.imageDescription)
                            .resizable()
                            .cornerRadius(10)
                    }
                }
                .width(4)

                Section {
                    Text(article.text)
                        .font(.lead)
                }
                .width(8)
            }
            .class("row")
        }
        .frame(maxWidth: 900)
        .padding(.horizontal, 5)
    }
}
