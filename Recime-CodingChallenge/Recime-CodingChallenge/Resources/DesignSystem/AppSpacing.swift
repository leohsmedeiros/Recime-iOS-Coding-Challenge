//
//  AppSpacing.swift
//  Recime-CodingChallenge
//
//  Created by Leonardo Medeiros on 30/03/26.
//

import CoreFoundation

// MARK: - Spacing Tokens

enum AppSpacing {
    static let xs:  CGFloat = 4    // 0.25rem
    static let sm:  CGFloat = 8    // 0.5rem
    static let md:  CGFloat = 12   // 0.75rem
    static let lg:  CGFloat = 16   // 1rem
    static let xl:  CGFloat = 20   // 1.25rem
    static let xxl: CGFloat = 24   // 1.5rem
    /// Card vertical breathing room — separates image from title (1.75rem)
    static let s5:  CGFloat = 28
    static let s8:  CGFloat = 32   // 2rem
    /// 3.5rem offset token — asymmetric editorial margin
    static let s10: CGFloat = 40
    /// 4rem offset token — hero container padding
    static let s12: CGFloat = 48
}

// MARK: - Corner Radius Tokens

enum AppRadius {
    /// Underline-only on active tertiary buttons (0.25rem)
    static let sm: CGFloat = 4
    static let md: CGFloat = 8
    /// Content cards — 1rem
    static let lg: CGFloat = 16
    /// Hero containers / modal sheets — 1.5rem
    static let xl: CGFloat = 24
}
