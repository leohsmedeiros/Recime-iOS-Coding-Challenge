//
//  MockRecipeService.swift
//  Recime-CodingChallenge
//
//  Created by Leonardo Medeiros on 26/03/26.
//


import Foundation
@testable import Recime_CodingChallenge

final class MockRecipeService: RecipeService {
    var fetchAllRecipesResult: Result<[Recipe], Error> = .success([])
    var searchRecipesResult: Result<[Recipe], Error> = .success([])

    private(set) var fetchAllRecipesCalled = false
    private(set) var searchRecipesCalled = false
    private(set) var receivedSearch: RecipeSearch?

    func fetchAllRecipes() async throws -> [Recipe] {
        fetchAllRecipesCalled = true
        return try fetchAllRecipesResult.get()
    }

    func searchRecipes(_ recipeSearch: RecipeSearch) async throws -> [Recipe] {
        searchRecipesCalled = true
        receivedSearch = recipeSearch
        return try searchRecipesResult.get()
    }
}