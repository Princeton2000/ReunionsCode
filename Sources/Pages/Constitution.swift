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

    var body: some HTML {
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
