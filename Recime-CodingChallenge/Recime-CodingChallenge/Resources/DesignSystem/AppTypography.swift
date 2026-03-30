//
//  AppTypography.swift
//  Recime-CodingChallenge
//
//  Created by Leonardo Medeiros on 30/03/26.
//

import SwiftUI

// MARK: - Font Tokens

extension Font {
    enum App {

        // MARK: Display — Noto Serif (hero moments, recipe titles)
        static let displayLg = Font.custom("NotoSerif-Bold",    size: 48, relativeTo: .largeTitle)
        static let displayMd = Font.custom("NotoSerif-Regular", size: 34, relativeTo: .title)
        static let displaySm = Font.custom("NotoSerif-Regular", size: 28, relativeTo: .title2)

        // MARK: Title — Manrope (navigation, section headings)
        static let titleLg = Font.custom("Manrope-SemiBold", size: 22, relativeTo: .title3)
        static let titleMd = Font.custom("Manrope-SemiBold", size: 18, relativeTo: .headline)
        static let titleSm = Font.custom("Manrope-Medium",   size: 16, relativeTo: .subheadline)

        // MARK: Body — Manrope (instructions, descriptions)
        static let bodyLg = Font.custom("Manrope-Regular", size: 16, relativeTo: .body)
        static let bodySm = Font.custom("Manrope-Regular", size: 14, relativeTo: .callout)

        // MARK: Label — Manrope (uppercase eyebrows, chips)
        /// Always render uppercase with 0.8pt tracking as a tiered "eyebrow" label.
        static let labelMd = Font.custom("Manrope-Medium",  size: 12, relativeTo: .caption)
        static let labelSm = Font.custom("Manrope-Regular", size: 10, relativeTo: .caption2)
    }
}

// MARK: - Eyebrow Style Modifier

/// Uppercase, tracked label used above headlines to build tiered information architecture.
struct EyebrowStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.App.labelMd)
            .textCase(.uppercase)
            .tracking(0.8)
            .foregroundStyle(Color.App.onSurfaceVariant)
    }
}

extension View {
    func eyebrowStyle() -> some View {
        modifier(EyebrowStyle())
    }
}
