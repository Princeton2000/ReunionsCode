//
//  Library.swift
//  Princeton2000
//
//  Library page - showcasing classmate works
//

import Foundation
import Ignite

struct Library: StaticPage {
    @Environment(\.decode) var decode

    var title = "Library"
    var description = "Books, films, and works by Princeton Class of 2000 classmates."

    func entriesByClassmate(_ classmate: Classmate, from entries: [LibraryEntry]) -> [LibraryEntry] {
        let classmateEntries = entries.filter({ $0.classmate == classmate })
        return classmateEntries.filter({ $0.title != nil }).sorted(by: { $0.date > $1.date })
    }

    @MainActor
    func classmateSection(_ classmate: Classmate, entries: [LibraryEntry]) -> some HTML {
        let classmateEntries = entriesByClassmate(classmate, from: entries)
        return Group {
            Text("\(classmate.description.replacingOccurrences(of: "\n", with: "<p>"))")
                .padding([.leading, .vertical])
                .font(.title1)
                .fontWeight(.semibold)
                .background(.princetonOrange)
                .padding(.vertical)
                .id(classmate.id)
            Section {
                for (index, entry) in classmateEntries.enumerated() {
                    if entry.musicEntry {
                        libraryMusicRow(entry)
                    } else {
                        libraryRow(entry, includeDivider: index != classmateEntries.count - 1)
                    }
                }
            }
            .padding(.horizontal)
        }
    }

    var body: some HTML {
        Include("styleInjection.html")

        if let entries = decode("library.json", as: [LibraryEntry].self) {
            let classmates: [Classmate] = Array(Set(entries.map { $0.classmate })).sorted(by: { $0.lastName < $1.lastName })
            let activeClassmates: [Classmate] = classmates.filter({ entriesByClassmate($0, from: entries).count > 0 })

            for classmate in activeClassmates {
                classmateSection(classmate, entries: entries)
            }
        }
    }
}
