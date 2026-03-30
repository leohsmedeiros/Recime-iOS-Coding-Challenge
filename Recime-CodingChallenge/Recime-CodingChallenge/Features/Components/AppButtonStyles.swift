//
//  AppButtonStyles.swift
//  Recime-CodingChallenge
//
//  Created by Leonardo Medeiros on 30/03/26.
//

import SwiftUI

// MARK: - Primary Button Style
/// Gradient fill from `primary` → `primaryContainer` at 135°.
/// xl (1.5rem) rounded corners. onPrimary text color.
struct AppPrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.App.titleSm)
            .foregroundStyle(Color.App.onPrimary)
            .padding(.horizontal, AppSpacing.xxl)
            .padding(.vertical, AppSpacing.md)
            .background(
                LinearGradient(
                    colors: [Color.App.primary, Color.App.primaryContainer],
                    startPoint: UnitPoint(x: 0.15, y: 0),
                    endPoint: UnitPoint(x: 0.85, y: 1)
                )
            )
            .clipShape(RoundedRectangle(cornerRadius: AppRadius.xl))
            .opacity(configuration.isPressed ? 0.88 : 1)
            .scaleEffect(configuration.isPressed ? 0.97 : 1)
            .animation(.easeInOut(duration: 0.12), value: configuration.isPressed)
    }
}

// MARK: - Tertiary Button Style
/// Ghost style: no background, `primary` text.
/// A sm (0.25rem) bottom-underline appears only on press/active state.
struct AppTertiaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.App.titleSm)
            .foregroundStyle(Color.App.primary)
            .padding(.vertical, AppSpacing.xs)
            .overlay(alignment: .bottom) {
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(Color.App.primary)
                    .opacity(configuration.isPressed ? 1 : 0)
                    .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
            }
    }
}

// MARK: - ButtonStyle Extensions

extension ButtonStyle where Self == AppPrimaryButtonStyle {
    static var appPrimary: AppPrimaryButtonStyle { .init() }
}

extension ButtonStyle where Self == AppTertiaryButtonStyle {
    static var appTertiary: AppTertiaryButtonStyle { .init() }
}

// MARK: - Preview

#Preview("Button Styles") {
    VStack(spacing: AppSpacing.xl) {
        Button("Apply Filters") {}
            .buttonStyle(.appPrimary)

        Button("Reset") {}
            .buttonStyle(.appTertiary)
    }
    .padding(AppSpacing.s10)
    .background(Color.App.surface)
}
