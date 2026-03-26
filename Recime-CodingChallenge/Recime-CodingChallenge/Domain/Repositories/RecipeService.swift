//
//  RecipeService.swift
//  Recime-CodingChallenge
//
//  Created by Leonardo Medeiros on 25/03/26.
//


protocol RecipeService {
    func fetchRecipes(filters: RecipeSearchFilters) async throws -> [Recipe]
}
