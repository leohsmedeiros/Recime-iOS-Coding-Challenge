//
//  RecipeServiceAPIError.swift
//  Recime-CodingChallenge
//
//  Created by Leonardo Medeiros on 25/03/26.
//


import Foundation

enum RecipeServiceAPIError: LocalizedError {
    case fileNotFound
    case decodingFailed(Error)

    var errorDescription: String? {
        switch self {
        case .fileNotFound:
            return "Could not find the bundled recipes file."
        case .decodingFailed(let error):
            return "Failed to decode recipes: \(error.localizedDescription)"
        }
    }
}
