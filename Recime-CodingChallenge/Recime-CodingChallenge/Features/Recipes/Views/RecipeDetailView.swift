//
//  RecipeDetailView.swift
//  Recime-CodingChallenge
//
//  Created by Leonardo Medeiros on 25/03/26.
//

import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe

    private let heroHeight: CGFloat = 320

    private var heroGradient: LinearGradient {
        LinearGradient(
            colors: [Color.App.primaryContainer, Color.App.primary],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {

                // MARK: Hero — food imagery stand-in
                ZStack(alignment: .bottomLeading) {
                    heroGradient
                        .frame(height: heroHeight)

                    VStack(alignment: .leading, spacing: AppSpacing.sm) {
                        Text(recipe.title)
                            .font(.App.displayLg)
                            .foregroundStyle(Color.App.onPrimary)
                            .fixedSize(horizontal: false, vertical: true)

                        Label("\(recipe.servings) servings", systemImage: "person.2")
                            .font(.App.bodyLg)
                            .foregroundStyle(Color.App.onPrimaryContainer)
                    }
                    .padding(.leading, AppSpacing.s10)
                    .padding(.trailing, AppSpacing.lg)
                    .padding(.bottom, AppSpacing.s12 + AppRadius.xl)
                }

                // MARK: Content Sheet — slides over the hero
                contentSheet
                    .background(Color.App.surfaceContainerLowest)
                    .clipShape(
                        UnevenRoundedRectangle(
                            topLeadingRadius: AppRadius.md,
                            bottomLeadingRadius: 0,
                            bottomTrailingRadius: 0,
                            topTrailingRadius: AppRadius.md
                        )
                    )
                    .offset(y: -AppRadius.xl)
                    .padding(.bottom, -AppRadius.xl)
            }
        }
        .ignoresSafeArea(edges: .top)
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.App.surfaceContainerLowest)
    }

    // MARK: - Content Sheet

    @ViewBuilder
    private var contentSheet: some View {
        VStack(alignment: .leading, spacing: AppSpacing.s5) {

            Text(recipe.description)
                .font(.App.bodyLg)
                .foregroundStyle(Color.App.onSurfaceVariant)

            if !recipe.dietaryAttributes.isEmpty {
                VStack(alignment: .leading, spacing: AppSpacing.md) {
                    Text("Dietary")
                        .eyebrowStyle()

                    HStack(spacing: AppSpacing.sm) {
                        ForEach(recipe.dietaryAttributes, id: \.self) { attr in
                            SelectionChip(
                                title: attr.displayName,
                                isSelected: true,
                                action: {}
                            )
                        }
                    }
                }
            }

            VStack(alignment: .leading, spacing: AppSpacing.md) {
                Text("Ingredients")
                    .eyebrowStyle()

                VStack(alignment: .leading, spacing: 0) {
                    ForEach(recipe.ingredients, id: \.self) { ingredient in
                        HStack(spacing: AppSpacing.md) {
                            Circle()
                                .fill(Color.App.primaryFixedDim)
                                .frame(width: 6, height: 6)

                            Text(ingredient)
                                .font(.App.bodyLg)
                                .foregroundStyle(Color.App.onSurface)

                            Spacer()
                        }
                        .padding(.vertical, AppSpacing.xs)
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: AppRadius.md))
            }

            VStack(alignment: .leading, spacing: AppSpacing.md) {
                Text("Instructions")
                    .eyebrowStyle()

                VStack(alignment: .leading, spacing: AppSpacing.lg) {
                    ForEach(Array(recipe.instructions.enumerated()), id: \.offset) { index, step in
                        HStack(alignment: .center, spacing: AppSpacing.xs) {
                            Text("\(index + 1)")
                                .font(.App.labelMd)
                                .foregroundStyle(Color.App.onSecondaryContainer)
                                .frame(width: 28, height: 28)
                                .background(Color.App.secondaryContainer)
                                .clipShape(Circle())

                            Text(step)
                                .font(.App.bodyLg)
                                .foregroundStyle(Color.App.onSurface)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }
                }
            }
        }
        .padding(AppSpacing.lg)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// MARK: - Preview

#Preview("Recipe Detail") {
    NavigationStack {
        RecipeDetailView(recipe: .mock)
    }
}
