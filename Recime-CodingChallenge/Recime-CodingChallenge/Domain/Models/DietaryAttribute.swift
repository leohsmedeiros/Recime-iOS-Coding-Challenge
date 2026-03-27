//
//  DietaryAttribute.swift
//  Recime-CodingChallenge
//
//  Created by Leonardo Medeiros on 25/03/26.
//


enum DietaryAttribute: String, Codable, CaseIterable, Hashable {
    case vegetarian
    case glutenFree
    case dairyFree
    
    var displayName: String {
        switch self {
        case .vegetarian: return "Vegetarian"
        case .glutenFree: return "Gluten Free"
        case .dairyFree: return "Dairy Free"
        }
    }
}
