//
//  SelectionChip.swift
//  Recime-CodingChallenge
//
//  Created by Leonardo Medeiros on 30/03/26.
//

import SwiftUI

struct SelectionChip: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .eyebrowStyle()
                .foregroundStyle(
                    isSelected
                        ? Color.App.onSecondaryContainer
                        : Color.App.onSurfaceVariant
                )
                .padding(.horizontal, AppSpacing.md)
                .padding(.vertical, AppSpacing.sm)
                .background(
                    isSelected
                        ? Color.App.secondaryContainer
                        : Color.App.surfaceContainerHigh
                )
                .clipShape(Capsule())
                .animation(.easeInOut(duration: 0.15), value: isSelected)
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Preview

#Preview("Selection Chips") {
    HStack(spacing: AppSpacing.sm) {
        SelectionChip(title: "Vegetarian", isSelected: true, action: {})
        SelectionChip(title: "Gluten Free", isSelected: false, action: {})
        SelectionChip(title: "Dairy Free", isSelected: false, action: {})
    }
    .padding(AppSpacing.lg)
    .background(Color.App.surface)
}
