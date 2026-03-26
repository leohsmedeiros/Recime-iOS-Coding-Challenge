//
//  RecipeFiltersView.swift
//  Recime-CodingChallenge
//
//  Created by Leonardo Medeiros on 25/03/26.
//


import SwiftUI

struct RecipeFiltersView: View {
    @Binding var filters: RecipeSearch
    @Environment(\.dismiss) private var dismiss
    
    @State private var vegetarianOnly: Bool = false
    @State private var includedText = ""
    @State private var excludedText = ""
    @State private var servingsText = ""
    @State private var instructionQuery = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Dietary") {
                    Toggle("Vegetarian only", isOn: $vegetarianOnly)
                }
                
                Section("Servings") {
                    TextField("e.g. 2", text: $servingsText)
                        .keyboardType(.numberPad)
                }
                
                Section("Include ingredients") {
                    TextField("e.g. tomato, basil", text: $includedText)
                }
                
                Section("Exclude ingredients") {
                    TextField("e.g. garlic, onion", text: $excludedText)
                }
                
                Section("Instruction search") {
                    TextField("e.g. bake, simmer", text: $instructionQuery)
                }
            }
            .navigationTitle("Filters")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Reset") {
                        filters = RecipeSearch()
                        vegetarianOnly = false
                        includedText = ""
                        excludedText = ""
                        servingsText = ""
                        instructionQuery = ""
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        filters = RecipeSearch(
                            query: filters.query,
                            vegetarianOnly: vegetarianOnly,
                            servings: Int(servingsText),
                            includedIngredients: parseCommaSeparatedValues(includedText),
                            excludedIngredients: parseCommaSeparatedValues(excludedText),
                            instructionQuery: instructionQuery
                        )
                        
                        dismiss()
                    }
                }
            }
            .onAppear {
                vegetarianOnly = filters.vegetarianOnly
                includedText = filters.includedIngredients.joined(separator: ", ")
                excludedText = filters.excludedIngredients.joined(separator: ", ")
                if let servings = filters.servings {
                    servingsText = "\(servings)"
                }
                instructionQuery = filters.instructionQuery
            }
        }
    }
    
    private func parseCommaSeparatedValues(_ value: String) -> [String] {
        value
            .split(separator: ",")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
    }
}

#Preview("Empty Filters") {
    PreviewEmptyContainer()
}

private struct PreviewEmptyContainer: View {
    @State var filters = RecipeSearch()
    
    var body: some View {
        RecipeFiltersView(filters: $filters)
    }
}
