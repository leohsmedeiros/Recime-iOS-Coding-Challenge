//
//  Recipe.swift
//  Recime-CodingChallenge
//
//  Created by Leonardo Medeiros on 25/03/26.
//


import Foundation

struct Recipe: Identifiable, Codable, Hashable {
    let id: UUID
    let title: String
    let description: String
    let servings: Int
    let ingredients: [String]
    let instructions: [String]
    let dietaryAttributes: [DietaryAttribute]
}

extension Recipe {
    static let mock = Recipe(
        id: UUID(),
        title: "Vegetarian Pasta",
        description: "A quick and flavorful pasta with tomatoes and basil.",
        servings: 2,
        ingredients: ["Pasta", "Tomato", "Basil", "Garlic"],
        instructions: [
            "Boil pasta.",
            "Cook sauce.",
            "Combine and serve."
        ],
        dietaryAttributes: [.vegetarian]
    )
}
