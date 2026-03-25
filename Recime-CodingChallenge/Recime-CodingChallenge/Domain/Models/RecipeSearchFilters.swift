//
//  RecipeSearchFilters.swift
//  Recime-CodingChallenge
//
//  Created by Leonardo Medeiros on 25/03/26.
//


import Foundation

struct RecipeSearchFilters: Equatable {
    var query: String = ""
    var vegetarianOnly: Bool = false
    var servings: Int?
    var includedIngredients: [String] = []
    var excludedIngredients: [String] = []
    var instructionQuery: String = ""
}