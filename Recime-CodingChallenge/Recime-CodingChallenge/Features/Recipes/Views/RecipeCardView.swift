//
//  RecipeCardView.swift
//  Recime-CodingChallenge
//
//  Created by Leonardo Medeiros on 25/03/26.
//

import SwiftUI

struct RecipeCardView: View {
    let recipe: Recipe

    private var heroGradient: LinearGradient {
        LinearGradient(
            colors: [Color.App.primaryContainer, Color.App.primary],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {

            // MARK: Hero — dietary badges float over the gradient
            ZStack(alignment: .bottomLeading) {
                heroGradient
                    .frame(height: 140)

                if !recipe.dietaryAttributes.isEmpty {
                    HStack(spacing: AppSpacing.xs) {
                        ForEach(recipe.dietaryAttributes, id: \.self) { attr in
                            Text(attr.displayName)
                                .eyebrowStyle()
                                .foregroundStyle(Color.App.primaryFixedDim)
                        }
                    }
                    .padding(.horizontal, AppSpacing.lg)
                    .padding(.bottom, AppSpacing.md)
                }
            }

            // MARK: Content — spacing-5 separates hero from title
            VStack(alignment: .leading, spacing: AppSpacing.sm) {

                Label("\(recipe.servings) servings", systemImage: "person.2")
                    .eyebrowStyle()
                    .foregroundStyle(Color.App.primaryFixedDim)

                Text(recipe.title)
                    .font(.App.displaySm)
                    .foregroundStyle(Color.App.onSurface)
                    .lineLimit(2)

                Text(recipe.description)
                    .font(.App.bodySm)
                    .foregroundStyle(Color.App.onSurfaceVariant)
                    .lineLimit(2)
            }
            .padding(.horizontal, AppSpacing.lg)
            .padding(.top, AppSpacing.s5)
            .padding(.bottom, AppSpacing.xl)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .background(Color.App.surfaceContainerLowest)
        .clipShape(RoundedRectangle(cornerRadius: AppRadius.lg))
        .ambientShadow()
    }
}

// MARK: - Preview

#Preview("Recipe Card") {
    RecipeCardView(recipe: .mock)
        .padding(AppSpacing.lg)
        .background(Color.App.surface)
}
