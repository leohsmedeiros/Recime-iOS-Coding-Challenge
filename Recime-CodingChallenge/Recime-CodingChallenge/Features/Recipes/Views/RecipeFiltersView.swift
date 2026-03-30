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
            ScrollView {
                VStack(alignment: .leading, spacing: AppSpacing.s8) {

                    // MARK: Dietary
                    filterSection("Dietary") {
                        SelectionChip(
                            title: "Vegetarian",
                            isSelected: vegetarianOnly
                        ) {
                            vegetarianOnly.toggle()
                        }
                    }

                    // MARK: Servings
                    filterSection("Servings") {
                        FloatingLabelTextField(
                            label: "Number of servings",
                            text: $servingsText,
                            keyboardType: .numberPad
                        )
                    }

                    // MARK: Ingredients
                    filterSection("Include Ingredients") {
                        FloatingLabelTextField(
                            label: "e.g. tomato, basil",
                            text: $includedText
                        )
                    }

                    filterSection("Exclude Ingredients") {
                        FloatingLabelTextField(
                            label: "e.g. garlic, onion",
                            text: $excludedText
                        )
                    }

                    // MARK: Instructions
                    filterSection("Instruction Search") {
                        FloatingLabelTextField(
                            label: "e.g. bake, simmer",
                            text: $instructionQuery
                        )
                    }
                }
                .padding(.horizontal, AppSpacing.lg)
                .padding(.vertical, AppSpacing.md)
            }
            .background(Color.App.surfaceContainerLow)
            .navigationTitle("Filters")
            .navigationBarTitleDisplayMode(.inline)
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
                    Button("Apply") {
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

    // MARK: - Helpers

    @ViewBuilder
    private func filterSection<Content: View>(
        _ title: String,
        @ViewBuilder content: () -> Content
    ) -> some View {
        VStack(alignment: .leading, spacing: AppSpacing.md) {
            Text(title)
                .eyebrowStyle()
            content()
        }
    }

    private func parseCommaSeparatedValues(_ value: String) -> [String] {
        value
            .split(separator: ",")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
    }
}

// MARK: - Preview

#Preview("Filters") {
    @Previewable @State var filters = RecipeSearch()
    RecipeFiltersView(filters: $filters)
}
