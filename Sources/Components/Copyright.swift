//
//  Copyright.swift
//  Princeton2000
//
//  Copyright footer component migrated to new Ignite API
//

import Foundation
import Ignite

struct Copyright: HTML {
    var calendar: Calendar = .current
    var year: Int { return Calendar.current.component(.year, from: Date()) }

    var body: some HTML {
        Text {
            "© \(year) Princeton Class of 2000. All Rights Reserved."
        }
        .font(.title6)
        .foregroundStyle(.tertiary)
        .style(.font, "1rem/4.0")

        Text {
            "Created with "
            Link("Ignite", target: "https://github.com/twostraws/Ignite")
        }
        .font(.title6)
        .foregroundStyle(.tertiary)
        .style(.font, "1rem/4.0")
    }
}
