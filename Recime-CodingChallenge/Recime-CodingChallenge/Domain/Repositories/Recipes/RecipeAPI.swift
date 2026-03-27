//
//  RecipeAPI.swift
//  Recime-CodingChallenge
//
//  Created by Leonardo Medeiros on 26/03/26.
//

protocol RecipeAPI {
    func getRecipes() async throws -> [Recipe]
}
