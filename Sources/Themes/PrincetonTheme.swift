//
//  PrincetonTheme.swift
//  Princeton2000
//
//  Custom theme with Princeton branding colors
//

import Foundation
import Ignite

struct PrincetonLightTheme: Theme {
    var colorScheme: ColorScheme = .light

    // Princeton Orange as accent
    var accent: Color = Color(hex: "#EE7F2D")
    var secondaryAccent: Color = Color(hex: "#2D2C2F")

    // Link colors
    var link: Color = Color(hex: "#EE7F2D")
    var hoveredLink: Color = Color(hex: "#CC6B26")
}

struct PrincetonDarkTheme: Theme {
    var colorScheme: ColorScheme = .dark

    // Slightly brighter orange for dark mode
    var accent: Color = Color(hex: "#FF9F4D")
    var secondaryAccent: Color = Color(hex: "#4D4C4F")

    // Link colors
    var link: Color = Color(hex: "#FF9F4D")
    var hoveredLink: Color = Color(hex: "#FFBF7D")
}
