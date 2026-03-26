//
//  APIRequest.swift
//  Recime-CodingChallenge
//
//  Created by Leonardo Medeiros on 26/03/26.
//

protocol APIRequest {
    func getRecipes() async throws -> [Recipe]
}
