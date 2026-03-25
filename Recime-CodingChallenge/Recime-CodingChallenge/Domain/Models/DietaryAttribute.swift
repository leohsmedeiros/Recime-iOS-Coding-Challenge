//
//  DietaryAttribute.swift
//  Recime-CodingChallenge
//
//  Created by Leonardo Medeiros on 25/03/26.
//


enum DietaryAttribute: String, Codable, CaseIterable, Hashable {
    case vegetarian
    case vegan
    case glutenFree
    case dairyFree
}