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
    @Published private(set) var recipes: [Recipe] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

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
    func searchRecipes(filters: RecipeSearchFilters) async {
        isLoading = true
        errorMessage = nil

        do {
            recipes = try await service.searchRecipes(filters: filters)
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }

}
