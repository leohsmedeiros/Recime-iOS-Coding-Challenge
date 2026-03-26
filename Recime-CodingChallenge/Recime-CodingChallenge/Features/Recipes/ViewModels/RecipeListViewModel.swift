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
    func loadAllRecipes() async {
        isLoading = true
        errorMessage = nil

        do {
            recipes = try await service.fetchAllRecipes()
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
    
    @MainActor
    func searchRecipes(search: RecipeSearch) async {
        isLoading = true
        errorMessage = nil

        do {
            recipes = try await service.searchRecipes(search)
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }

}
