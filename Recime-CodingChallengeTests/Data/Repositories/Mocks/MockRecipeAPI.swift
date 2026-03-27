//
//  MockRecipeAPI.swift
//  Recime-CodingChallenge
//
//  Created by Leonardo Medeiros on 26/03/26.
//

import Foundation
@testable import Recime_CodingChallenge

final class MockRecipeAPI: RecipeAPI {
    func getRecipes() async throws -> [Recipe] {
        return [
            Recipe(id: UUID(uuidString: "1E2D3C4B-0001-4A1B-8F00-000000000001")!,
                   title: "Vegetarian Pasta",
                   description: "A quick and flavorful pasta with tomatoes and basil.",
                   servings: 1,
                   ingredients: ["pasta", "tomato", "basil", "olive oil", "garlic"],
                   instructions: [
                    "Boil the pasta until al dente.",
                    "Saute garlic in olive oil.",
                    "Add tomatoes and cook for 5 minutes.",
                    "Mix pasta with sauce and top with basil."
                   ],
                   dietaryAttributes: [.vegetarian]),
            Recipe(id: UUID(uuidString: "1E2D3C4B-0002-4A1B-8F00-000000000002")!,
                   title: "Grilled Chicken Salad",
                   description: "A healthy salad with grilled chicken and fresh greens.",
                   servings: 2,
                   ingredients: ["chicken breast", "lettuce", "tomato", "cucumber", "olive oil"],
                   instructions: [
                    "Season and grill the chicken.",
                    "Chop vegetables and mix in a bowl.",
                    "Slice chicken and place on top.",
                    "Drizzle with olive oil and serve."
                   ],
                   dietaryAttributes: []),
            Recipe(id: UUID(uuidString: "1E2D3C4B-0003-4A1B-8F00-000000000003")!,
                   title: "Vegan Buddha Bowl",
                   description: "A nourishing bowl with quinoa and roasted vegetables.",
                   servings: 3,
                   ingredients: ["quinoa", "sweet potato", "chickpeas", "spinach", "olive oil"],
                   instructions: [
                    "Cook quinoa according to package instructions.",
                    "Roast sweet potatoes and chickpeas.",
                    "Assemble bowl with spinach and quinoa.",
                    "Top with roasted vegetables."
                   ],
                   dietaryAttributes: [.glutenFree]),
        ]
    }
}
