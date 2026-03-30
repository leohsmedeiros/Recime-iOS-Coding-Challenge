//
//  AppElevation.swift
//  Recime-CodingChallenge
//
//  Created by Leonardo Medeiros on 30/03/26.
//

import SwiftUI

// MARK: - Ambient Shadow
/// Extra-diffused shadow that mimics natural room light.
/// offset-y: 8px, blur: 24px, color: onSurface @ 6%
struct AmbientShadow: ViewModifier {
    func body(content: Content) -> some View {
        content.shadow(
            color: Color.App.onSurface.opacity(0.06),
            radius: 24,
            x: 0,
            y: 8
        )
    }
}

// MARK: - Ghost Border
/// Suggestion of a border at 15% outlineVariant — never a solid 1px line.
/// Use when high-key imagery makes a container edge disappear.
struct GhostBorder: ViewModifier {
    var cornerRadius: CGFloat = AppRadius.lg

    func body(content: Content) -> some View {
        content.overlay(
            RoundedRectangle(cornerRadius: cornerRadius)
                .strokeBorder(Color.App.outlineVariant.opacity(0.15), lineWidth: 1)
        )
    }
}

// MARK: - Frosted Glass
/// surfaceVariant @ 40% opacity + system thin material blur.
/// For floating recipe cards overlaid on food photography.
struct FrostedGlass: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(.ultraThinMaterial)
            .background(Color.App.surfaceVariant.opacity(0.4))
    }
}

// MARK: - Glass Navigation Bar
/// surface @ 70% opacity for floating nav bars and header overlays.
struct GlassNavigationBar: ViewModifier {
    func body(content: Content) -> some View {
        content
            .toolbarBackground(Color.App.surface.opacity(0.7), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
    }
}

// MARK: - View Extensions

extension View {
    func ambientShadow() -> some View {
        modifier(AmbientShadow())
    }

    func ghostBorder(cornerRadius: CGFloat = AppRadius.lg) -> some View {
        modifier(GhostBorder(cornerRadius: cornerRadius))
    }

    func frostedGlass() -> some View {
        modifier(FrostedGlass())
    }

    func glassNavigationBar() -> some View {
        modifier(GlassNavigationBar())
    }
}
