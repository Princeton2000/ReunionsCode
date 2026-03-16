//
//  EmbedLayout.swift
//  Princeton2000
//
//  Minimal layout for pages embedded via iframe (no nav, no footer)
//

import Foundation
import Ignite

struct EmbedLayout: Layout {
    var body: some Document {
        Head {
            MetaLink(href: "/css/fonts.css", rel: .stylesheet)
            MetaLink(href: "/css/theme.css", rel: .stylesheet)
            MetaLink(href: "/css/layout.css", rel: .stylesheet)
            Script(code: """
                var s = document.createElement('style');
                s.textContent = '[data-bs-theme*="dark"] img[src*="Lounging_Tiger"] { filter: invert(1) hue-rotate(180deg) !important; }';
                document.head.appendChild(s);
            """)
        }

        Body {
            content
        }
    }
}
