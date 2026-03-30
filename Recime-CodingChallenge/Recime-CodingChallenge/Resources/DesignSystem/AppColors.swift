//
//  AppColors.swift
//  Recime-CodingChallenge
//
//  Created by Leonardo Medeiros on 30/03/26.
//

import SwiftUI

extension Color {
    enum App {

        // MARK: - Primary — Deep Forest Green / Luminous Sage
        /// Light: deep forest. Dark: luminous sage (the actionable accent on dark surfaces).
        static let primary            = Color(light: "163422", dark: "8dd9a0")
        static let onPrimary          = Color(light: "ffffff", dark: "003914")
        static let primaryContainer   = Color(light: "2d4b37", dark: "1a4729")
        static let onPrimaryContainer = Color(light: "ecf3ea", dark: "a8efbb")
        /// Muted green for inactive icons and bullet dots.
        static let primaryFixedDim    = Color(light: "8dd9a0", dark: "72c089")

        // MARK: - Secondary — Sun-Ripened Gold / Candlelit Amber
        /// Light: deep warm gold. Dark: luminous gold that glows on dark surfaces.
        static let secondary              = Color(light: "735c00", dark: "e5c44f")
        static let onSecondary            = Color(light: "ffffff", dark: "3d2e00")
        static let secondaryContainer     = Color(light: "f5e0a0", dark: "574400")
        static let onSecondaryContainer   = Color(light: "241a00", dark: "fde68a")

        // MARK: - Surface Scale — Fine Paper / Cave Dining
        /// Level 0 — base canvas
        static let surface                  = Color(light: "f7faf4", dark: "10140f")
        /// Level 2 — interactive cards
        static let surfaceContainerLowest   = Color(light: "ffffff", dark: "0b0f0a")
        /// Level 1 — sections
        static let surfaceContainerLow      = Color(light: "f2f5ee", dark: "191d18")
        static let surfaceContainer         = Color(light: "eceee9", dark: "1d211c")
        static let surfaceContainerHigh     = Color(light: "e6e8e3", dark: "272b26")
        static let surfaceContainerHighest  = Color(light: "dfe2dc", dark: "323631")
        /// 40% opacity for frosted-glass card overlays
        static let surfaceVariant           = Color(light: "dce5d8", dark: "3c4438")

        // MARK: - On Surface
        /// Warm near-black / warm off-white — never pure black or pure white.
        static let onSurface            = Color(light: "191d19", dark: "e1e4de")
        static let onSurfaceVariant     = Color(light: "424940", dark: "c1c9be")
        /// Ghost border at 15% opacity — suggestion, not structure.
        static let outlineVariant       = Color(light: "c1c9be", dark: "424940")

        // MARK: - Error
        /// Use sparingly. Prefer `secondary` (gold) for low-severity warnings.
        static let error = Color(light: "ba1a1a", dark: "ffb4ab")
    }
}

// MARK: - Adaptive Color Initializer

private extension UIColor {
    convenience init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:  (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:  (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:  (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default: (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            alpha: Double(a) / 255
        )
    }
}

extension Color {
    /// Creates a color that adapts automatically to the current color scheme.
    init(light lightHex: String, dark darkHex: String) {
        self.init(uiColor: UIColor(dynamicProvider: { traits in
            traits.userInterfaceStyle == .dark
                ? UIColor(hex: darkHex)
                : UIColor(hex: lightHex)
        }))
    }

    /// Hex-only initializer — no dark mode adaptation.
    init(hex: String) {
        self.init(uiColor: UIColor(hex: hex))
    }
}
