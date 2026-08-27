//
//  Privacy.swift
//  Princeton2000
//
//  Privacy policy page
//

import Foundation
import Ignite

struct Privacy: StaticPage {
    var title = "Privacy"
    var description: String = "Privacy practices for the Princeton Class of 2000 reunions website — what data we collect, how cookies work, and how we protect your info."

    var body: some HTML {
        Text(title).font(.title1)

        Text(markdown: """
        ## Data We Collect

        This website uses Google Analytics to understand how visitors use the site. \
        Google Analytics collects anonymous usage data such as pages visited, time on site, \
        and general geographic region. No personally identifiable information is collected \
        through analytics.

        ## Cookies

        Google Analytics uses cookies to distinguish unique visitors. These cookies do not \
        contain personal information and are used solely for aggregate statistical analysis.

        ## Personal Information

        We do not collect, store, or process personal information through this website. \
        Registration for reunions is handled through Princeton University's separate \
        registration system.

        ## Contact

        For questions about these practices, contact us at \
        [social+web@princeton2000.org](mailto:social+web@princeton2000.org).

        ## Changes

        We may update this privacy statement from time to time. Any changes will be \
        reflected on this page.

        *Last updated: March 2027*
        """)
    }
}
