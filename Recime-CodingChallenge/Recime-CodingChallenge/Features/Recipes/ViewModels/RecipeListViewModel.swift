//
//  RecipeListViewModel.swift
//  Recime-CodingChallenge
//
//  Created by Leonardo Medeiros on 25/03/26.
//


import Foundation

@Observable
final class RecipeListViewModel {
    private(set) var recipes: [Recipe] = []
    var isLoading = false
    var errorMessage: String?

    @ObservationIgnored
    private let service: RecipeService

    init(service: RecipeService = RecipeServiceImpl()) {
        self.service = service
    }

    @MainActor
    func loadRecipes(search: RecipeSearch) async {
        isLoading = true
        errorMessage = nil

        do {
            if hasActiveFilter(search: search) || !search.query.isEmpty {
                recipes = try await service.searchRecipes(search)
            } else {
                recipes = try await service.fetchAllRecipes()
            }
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
    
    private func hasActiveFilter(search: RecipeSearch) -> Bool {
        if search.vegetarianOnly { return true }
        if search.servings != nil { return true }
        if !search.includedIngredients.isEmpty { return true }
        if !search.excludedIngredients.isEmpty { return true }
        if !search.instructionQuery.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return true
        }
        
        return false
    }
}
