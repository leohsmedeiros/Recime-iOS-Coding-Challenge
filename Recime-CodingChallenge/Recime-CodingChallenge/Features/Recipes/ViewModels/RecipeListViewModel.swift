//
//  RecipeListViewModel.swift
//  Recime-CodingChallenge
//
//  Created by Leonardo Medeiros on 25/03/26.
//


import Foundation
import SwiftUI
import Combine

final class RecipeListViewModel: ObservableObject {
    @Published private(set) var allRecipes: [Recipe] = []
    @Published private(set) var visibleRecipes: [Recipe] = []
    @Published var filters = RecipeSearchFilters()
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let service: RecipeService

    init(service: RecipeService = RecipeServiceImpl()) {
        self.service = service
    }

    @MainActor
    func loadRecipes() async {
        isLoading = true
        errorMessage = nil

        do {
            let recipes = try await service.fetchRecipes()
            allRecipes = recipes
            applyFilters()
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }

    @MainActor
    func applyFilters() {
        visibleRecipes = allRecipes.filter { recipe in
            matchesQuery(recipe)
            && matchesVegetarian(recipe)
            && matchesServings(recipe)
            && matchesIncludedIngredients(recipe)
            && matchesExcludedIngredients(recipe)
            && matchesInstructionQuery(recipe)
        }
    }

    private func matchesQuery(_ recipe: Recipe) -> Bool {
        let query = filters.query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !query.isEmpty else { return true }

        return recipe.title.localizedCaseInsensitiveContains(query)
            || recipe.description.localizedCaseInsensitiveContains(query)
            || recipe.ingredients.contains(where: { $0.localizedCaseInsensitiveContains(query) })
    }

    private func matchesVegetarian(_ recipe: Recipe) -> Bool {
        guard filters.vegetarianOnly else { return true }
        return recipe.dietaryAttributes.contains(.vegetarian)
    }

    private func matchesServings(_ recipe: Recipe) -> Bool {
        guard let servings = filters.servings else { return true }
        return recipe.servings == servings
    }

    private func matchesIncludedIngredients(_ recipe: Recipe) -> Bool {
        guard !filters.includedIngredients.isEmpty else { return true }

        let lowercasedIngredients = recipe.ingredients.map { $0.lowercased() }
        return filters.includedIngredients.allSatisfy { ingredient in
            lowercasedIngredients.contains(where: { $0.contains(ingredient.lowercased()) })
        }
    }

    private func matchesExcludedIngredients(_ recipe: Recipe) -> Bool {
        guard !filters.excludedIngredients.isEmpty else { return true }

        let lowercasedIngredients = recipe.ingredients.map { $0.lowercased() }
        return !filters.excludedIngredients.contains { ingredient in
            lowercasedIngredients.contains(where: { $0.contains(ingredient.lowercased()) })
        }
    }

    private func matchesInstructionQuery(_ recipe: Recipe) -> Bool {
        let query = filters.instructionQuery.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !query.isEmpty else { return true }

        return recipe.instructions.contains { $0.localizedCaseInsensitiveContains(query) }
    }
}
