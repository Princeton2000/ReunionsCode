//
//  Constitution.swift
//  Princeton2000
//
//  Migrated to new Ignite API
//

import Foundation
import Ignite

struct Constitution: StaticPage {
    var title = "Class Constitution"
    var description = "Read the full text of the governing constitution of the Princeton Class of 2000, outlining class bylaws, officer roles, and elections."

    var body: some HTML {
        Text(title).font(.title1).class("visually-hidden")
        Text {
            Link("Class Constitution", target: "/constitution/constitution.pdf")
                .target(.newWindow)
                .relationship(.noOpener, .noReferrer)
        }
        .font(.title5)
        .fontWeight(.semibold)
        .horizontalAlignment(.center)

        Include("constitution.html")
    }
}
