//
//  Recipe.swift
//  Recime-CodingChallenge
//
//  Created by Leonardo Medeiros on 25/03/26.
//


import Foundation

struct Recipe: Identifiable, Codable, Hashable {
    let id: UUID
    let title: String
    let description: String
    let servings: Int
    let ingredients: [String]
    let instructions: [String]
    let dietaryAttributes: [DietaryAttribute]
}
