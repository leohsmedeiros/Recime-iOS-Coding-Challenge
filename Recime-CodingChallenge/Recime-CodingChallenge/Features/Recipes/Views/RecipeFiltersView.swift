//
//  RecipeFiltersView.swift
//  Recime-CodingChallenge
//
//  Created by Leonardo Medeiros on 25/03/26.
//


import SwiftUI

struct RecipeFiltersView: View {
    @Binding var filters: RecipeSearchFilters
    @Environment(\.dismiss) private var dismiss
    
    @State private var queryText = ""
    @State private var includedText = ""
    @State private var excludedText = ""
    @State private var servingsText = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Query") {
                    TextField("", text: $queryText)
                        .onChange(of: queryText) { _, newValue in
                            filters.query = newValue
                        }
                }
                
                Section("Dietary") {
                    Toggle("Vegetarian only", isOn: $filters.vegetarianOnly)
                }
                
                Section("Servings") {
                    TextField("e.g. 2", text: $servingsText)
                        .keyboardType(.numberPad)
                        .onChange(of: servingsText) { _, newValue in
                            filters.servings = Int(newValue)
                        }
                }
                
                Section("Include ingredients") {
                    TextField("e.g. tomato, basil", text: $includedText)
                        .onChange(of: includedText) { _, newValue in
                            filters.includedIngredients = parseCSV(newValue)
                        }
                }
                
                Section("Exclude ingredients") {
                    TextField("e.g. garlic, onion", text: $excludedText)
                        .onChange(of: excludedText) { _, newValue in
                            filters.excludedIngredients = parseCSV(newValue)
                        }
                }
                
                Section("Instruction search") {
                    TextField("e.g. bake, simmer", text: $filters.instructionQuery)
                }
            }
            .navigationTitle("Filters")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Reset") {
                        filters = RecipeSearchFilters()
                        queryText = ""
                        includedText = ""
                        excludedText = ""
                        servingsText = ""
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
            .onAppear {
                queryText = filters.query
                includedText = filters.includedIngredients.joined(separator: ", ")
                excludedText = filters.excludedIngredients.joined(separator: ", ")
                if let servings = filters.servings {
                    servingsText = "\(servings)"
                }
            }
        }
    }
    
    private func parseCSV(_ value: String) -> [String] {
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
    @State var filters = RecipeSearchFilters()
    
    var body: some View {
        RecipeFiltersView(filters: $filters)
    }
}
