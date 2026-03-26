//
//  RecipeServiceImpl.swift
//  Recime-CodingChallenge
//
//  Created by Leonardo Medeiros on 25/03/26.
//


import Foundation

final class RecipeServiceImpl: RecipeService {
    func fetchAllRecipes() async throws -> [Recipe] {
        guard let url = Bundle.main.url(forResource: "recipes", withExtension: "json") else {
            throw RecipeServiceAPIError.fileNotFound
        }
        
        do {
            let data = try Data(contentsOf: url)
            let recipes = try JSONDecoder().decode([Recipe].self, from: data)
            return recipes
        } catch {
            throw RecipeServiceAPIError.decodingFailed(error)
        }
    }

    func searchRecipes(filters: RecipeSearchFilters) async throws -> [Recipe] {
        guard let url = Bundle.main.url(forResource: "recipes", withExtension: "json") else {
            throw RecipeServiceAPIError.fileNotFound
        }
        
        do {
            let data = try Data(contentsOf: url)
            let recipes = try JSONDecoder().decode([Recipe].self, from: data)
            let filteredRecipes = recipes.filter { recipe in
                matchesQuery(recipe, filters: filters)
                && matchesVegetarian(recipe, filters: filters)
                && matchesServings(recipe, filters: filters)
                && matchesIncludedIngredients(recipe, filters: filters)
                && matchesExcludedIngredients(recipe, filters: filters)
                && matchesInstructionQuery(recipe, filters: filters)
            }
            
            return filteredRecipes
        } catch {
            throw RecipeServiceAPIError.decodingFailed(error)
        }
    }
    
    private func matchesQuery(_ recipe: Recipe, filters: RecipeSearchFilters) -> Bool {
        let query = filters.query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !query.isEmpty else { return true }
        
        return recipe.title.localizedCaseInsensitiveContains(query)
        || recipe.description.localizedCaseInsensitiveContains(query)
        || recipe.ingredients.contains(where: { $0.localizedCaseInsensitiveContains(query) })
    }
    
    private func matchesVegetarian(_ recipe: Recipe, filters: RecipeSearchFilters) -> Bool {
        guard filters.vegetarianOnly else { return true }
        return recipe.dietaryAttributes.contains(.vegetarian)
    }
    
    private func matchesServings(_ recipe: Recipe, filters: RecipeSearchFilters) -> Bool {
        guard let servings = filters.servings else { return true }
        return recipe.servings == servings
    }
    
    private func matchesIncludedIngredients(_ recipe: Recipe, filters: RecipeSearchFilters) -> Bool {
        guard !filters.includedIngredients.isEmpty else { return true }
        
        let lowercasedIngredients = recipe.ingredients.map { $0.lowercased() }
        return filters.includedIngredients.allSatisfy { ingredient in
            lowercasedIngredients.contains(where: { $0.contains(ingredient.lowercased()) })
        }
    }
    
    private func matchesExcludedIngredients(_ recipe: Recipe, filters: RecipeSearchFilters) -> Bool {
        guard !filters.excludedIngredients.isEmpty else { return true }
        
        let lowercasedIngredients = recipe.ingredients.map { $0.lowercased() }
        return !filters.excludedIngredients.contains { ingredient in
            lowercasedIngredients.contains(where: { $0.contains(ingredient.lowercased()) })
        }
    }
    
    private func matchesInstructionQuery(_ recipe: Recipe, filters: RecipeSearchFilters) -> Bool {
        let query = filters.instructionQuery.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !query.isEmpty else { return true }
        
        return recipe.instructions.contains { $0.localizedCaseInsensitiveContains(query) }
    }
}
