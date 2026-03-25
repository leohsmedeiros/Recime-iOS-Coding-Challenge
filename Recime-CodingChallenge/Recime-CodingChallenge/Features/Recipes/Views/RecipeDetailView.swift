//
//  RecipeDetailView.swift
//  Recime-CodingChallenge
//
//  Created by Leonardo Medeiros on 25/03/26.
//


import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(recipe.title)
                    .font(.largeTitle.bold())
                
                Text(recipe.description)
                    .foregroundStyle(.secondary)
                
                Label("Serves \(recipe.servings)", systemImage: "person.2")
                
                if !recipe.dietaryAttributes.isEmpty {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Dietary")
                            .font(.headline)
                        
                        HStack {
                            ForEach(recipe.dietaryAttributes, id: \.self) { attr in
                                Text(attr.rawValue.capitalized)
                                    .font(.caption)
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 6)
                                    .background(.gray.opacity(0.15))
                                    .clipShape(Capsule())
                            }
                        }
                    }
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Ingredients")
                        .font(.headline)
                    
                    ForEach(recipe.ingredients, id: \.self) { ingredient in
                        Text("• \(ingredient)")
                    }
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Instructions")
                        .font(.headline)
                    
                    ForEach(Array(recipe.instructions.enumerated()), id: \.offset) { index, step in
                        Text("\(index + 1). \(step)")
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Recipe")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview("Recipe Detail") {
    let recipe = Recipe(id: UUID(),
                        title: "Vegetarian Pasta",
                        description: "A quick and flavorful pasta with tomatoes and basil.",
                        servings: 2,
                        ingredients: ["pasta", "tomato", "basil", "olive oil", "garlic"],
                        instructions: [
                            "Boil the pasta until al dente.",
                            "Saute garlic in olive oil.",
                            "Add tomatoes and cook for 5 minutes.",
                            "Mix pasta with sauce and top with basil."
                        ],
                        dietaryAttributes: [.vegetarian])
    RecipeDetailView(recipe: recipe)
}
