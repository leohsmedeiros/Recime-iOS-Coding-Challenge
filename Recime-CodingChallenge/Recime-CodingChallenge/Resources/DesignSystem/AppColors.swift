//
//  AppColors.swift
//  Recime-CodingChallenge
//
//  Created by Leonardo Medeiros on 30/03/26.
//

import SwiftUI

extension Color {
    enum App {

        // MARK: - Primary — Deep Forest Green
        static let primary              = Color(hex: "163422")
        static let onPrimary            = Color.white
        static let primaryContainer     = Color(hex: "2d4b37")
        static let onPrimaryContainer   = Color(hex: "ecf3ea")
        /// Muted green for inactive icons; avoids the harshness of grey.
        static let primaryFixedDim      = Color(hex: "8dd9a0")

        // MARK: - Secondary — Sun-Ripened Gold
        static let secondary              = Color(hex: "735c00")
        static let onSecondary            = Color.white
        static let secondaryContainer     = Color(hex: "f5e0a0")
        static let onSecondaryContainer   = Color(hex: "241a00")

        // MARK: - Surface Scale — Stacked Sheets of Fine Paper
        /// Level 0 — base canvas
        static let surface                  = Color(hex: "f7faf4")
        /// Level 2 — interactive cards (white)
        static let surfaceContainerLowest   = Color(hex: "ffffff")
        /// Level 1 — sections
        static let surfaceContainerLow      = Color(hex: "f2f5ee")
        static let surfaceContainer         = Color(hex: "eceee9")
        static let surfaceContainerHigh     = Color(hex: "e6e8e3")
        static let surfaceContainerHighest  = Color(hex: "dfe2dc")
        /// 40% opacity for frosted-glass card overlays
        static let surfaceVariant           = Color(hex: "dce5d8")

        // MARK: - On Surface
        /// Warm near-black — never use #000000
        static let onSurface            = Color(hex: "191d19")
        static let onSurfaceVariant     = Color(hex: "424940")
        /// Ghost border at 15% opacity — suggestion, not structure
        static let outlineVariant       = Color(hex: "c1c9be")

        // MARK: - Error
        /// Use sparingly. Prefer `secondary` (gold) for low-severity warnings.
        static let error = Color(hex: "ba1a1a")
    }
}

// MARK: - Hex Initializer

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
