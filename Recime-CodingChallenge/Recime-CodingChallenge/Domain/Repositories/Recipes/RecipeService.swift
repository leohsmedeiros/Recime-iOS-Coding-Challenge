//
//  RecipeService.swift
//  Recime-CodingChallenge
//
//  Created by Leonardo Medeiros on 25/03/26.
//


protocol RecipeService {
    func searchRecipes(_ recipeSearch: RecipeSearch) async throws -> [Recipe]
}
