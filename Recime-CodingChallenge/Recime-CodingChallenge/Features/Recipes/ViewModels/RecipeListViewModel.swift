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
            recipes = try await service.searchRecipes(search)
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
    
    public func computeActiveFilterCount(search: RecipeSearch) -> Int {
        var count = 0
        
        if search.vegetarianOnly { count += 1 }
        if search.servings != nil { count += 1 }
        if !search.includedIngredients.isEmpty { count += 1 }
        if !search.excludedIngredients.isEmpty { count += 1 }
        if !search.instructionQuery.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            count += 1
        }
        
        return count
    }
}
