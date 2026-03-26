//
//  LocalAPIRequest.swift
//  Recime-CodingChallenge
//
//  Created by Leonardo Medeiros on 26/03/26.
//


import Foundation

final class LocalAPIRequest: APIRequest {
    func getRecipes() async throws -> [Recipe] {
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
}
