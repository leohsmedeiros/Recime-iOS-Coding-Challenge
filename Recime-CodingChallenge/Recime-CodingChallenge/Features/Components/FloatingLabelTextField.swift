//
//  FloatingLabelTextField.swift
//  Recime-CodingChallenge
//
//  Created by Leonardo Medeiros on 30/03/26.
//

import SwiftUI

struct FloatingLabelTextField: View {
    let label: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default

    @FocusState private var isFocused: Bool

    private var isRaised: Bool { isFocused || !text.isEmpty }

    var body: some View {
        ZStack(alignment: .leading) {
            // Background + focus border
            RoundedRectangle(cornerRadius: AppRadius.md)
                .fill(Color.App.surfaceContainerLow)
                .overlay(
                    RoundedRectangle(cornerRadius: AppRadius.md)
                        .strokeBorder(
                            isFocused ? Color.App.secondary : Color.gray,
                            lineWidth: 1.5
                        )
                )

            // Floating label
            Text(label)
                .font(isRaised ? .App.labelSm : .App.bodyLg)
                .foregroundStyle(isFocused ? Color.App.secondary : Color.App.onSurfaceVariant)
                .offset(y: isRaised ? -10 : 0)
                .padding(.horizontal, AppSpacing.md)
                .animation(.spring(duration: 0.2), value: isRaised)

            // Input field — sits below label when raised
            TextField("", text: $text)
                .font(.App.bodyLg)
                .foregroundStyle(Color.App.onSurface)
                .keyboardType(keyboardType)
                .focused($isFocused)
                .padding(.horizontal, AppSpacing.md)
                .padding(.top, isRaised ? AppSpacing.lg : 0)
                .animation(.spring(duration: 0.2), value: isRaised)
        }
        .frame(height: 56)
        .contentShape(Rectangle())
        .onTapGesture { isFocused = true }
    }
}

// MARK: - Preview

#Preview("Floating Label") {
    @Previewable @State var text = ""
    @Previewable @State var filled = "tomato, basil"

    VStack(spacing: AppSpacing.md) {
        FloatingLabelTextField(label: "e.g. tomato, basil", text: $text)
        FloatingLabelTextField(label: "Include ingredients", text: $filled)
    }
    .padding(AppSpacing.s10)
    .background(Color.App.surfaceContainerLow)
}
