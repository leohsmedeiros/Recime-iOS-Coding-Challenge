//
//  RecipeServiceImpl.swift
//  Recime-CodingChallenge
//
//  Created by Leonardo Medeiros on 25/03/26.
//


import Foundation

final class RecipeServiceImpl: RecipeService {
    let api: RecipeAPI
    
    init(api: RecipeAPI = LocalRecipeAPI()) {
        self.api = api
    }

    func searchRecipes(_ recipeSearch: RecipeSearch) async throws -> [Recipe] {
        let recipes = try await api.getRecipes()
        return recipes.filter { recipe in
            matchesQuery(recipe, search: recipeSearch)
            && matchesVegetarianOnly(recipe, search: recipeSearch)
            && matchesServings(recipe, search: recipeSearch)
            && matchesIncludedIngredients(recipe, search: recipeSearch)
            && matchesExcludedIngredients(recipe, search: recipeSearch)
            && matchesInstructionQuery(recipe, search: recipeSearch)
        }
    }
    
    private func matchesQuery(_ recipe: Recipe, search: RecipeSearch) -> Bool {
        let query = search.query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !query.isEmpty else { return true }
        
        return recipe.title.localizedCaseInsensitiveContains(query)
        || recipe.description.localizedCaseInsensitiveContains(query)
        || recipe.ingredients.contains(where: { $0.localizedCaseInsensitiveContains(query) })
    }
    
    private func matchesVegetarianOnly(_ recipe: Recipe, search: RecipeSearch) -> Bool {
        guard search.vegetarianOnly else { return true }
        return recipe.dietaryAttributes.contains(.vegetarian)
    }
    
    private func matchesServings(_ recipe: Recipe, search: RecipeSearch) -> Bool {
        guard let servings = search.servings else { return true }
        return recipe.servings == servings
    }
    
    private func matchesIncludedIngredients(_ recipe: Recipe, search: RecipeSearch) -> Bool {
        guard !search.includedIngredients.isEmpty else { return true }
        
        let lowercasedIngredients = recipe.ingredients.map { $0.lowercased() }
        return search.includedIngredients.allSatisfy { ingredient in
            lowercasedIngredients.contains(where: { $0.contains(ingredient.lowercased()) })
        }
    }
    
    private func matchesExcludedIngredients(_ recipe: Recipe, search: RecipeSearch) -> Bool {
        guard !search.excludedIngredients.isEmpty else { return true }
        
        let lowercasedIngredients = recipe.ingredients.map { $0.lowercased() }
        return !search.excludedIngredients.contains { ingredient in
            lowercasedIngredients.contains(where: { $0.contains(ingredient.lowercased()) })
        }
    }
    
    private func matchesInstructionQuery(_ recipe: Recipe, search: RecipeSearch) -> Bool {
        let query = search.instructionQuery.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !query.isEmpty else { return true }
        
        return recipe.instructions.contains { $0.localizedCaseInsensitiveContains(query) }
    }
}
