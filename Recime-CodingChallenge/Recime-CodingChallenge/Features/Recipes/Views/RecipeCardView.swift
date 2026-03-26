//
//  RecipeCardView.swift
//  Recime-CodingChallenge
//
//  Created by Leonardo Medeiros on 25/03/26.
//


import SwiftUI

struct RecipeCardView: View {
    let recipe: Recipe

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(recipe.title)
                .font(.headline)

            Text(recipe.description)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .lineLimit(2)

            HStack {
                ForEach(recipe.dietaryAttributes, id: \.rawValue) {
                    Text($0.displayName)
                        .font(.caption)
                        .padding(4)
                        .background(.green.opacity(0.3))
                        .clipShape(Capsule())
                }
            }

            Label("\(recipe.servings)", systemImage: "person.2")
                .font(.caption)
        }
        .padding(.vertical, 4)
    }
}

#Preview("Recipe Card") {
    RecipeCardView(recipe: .mock)
}
