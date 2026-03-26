//
//  RecipeListView.swift
//  Recime-CodingChallenge
//
//  Created by Leonardo Medeiros on 25/03/26.
//


import SwiftUI

struct RecipeListView: View {
    @StateObject private var viewModel = RecipeListViewModel()
    @State private var recipeSearch = RecipeSearch()
    @State private var showingFilters = false

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading recipes...")
                } else if let errorMessage = viewModel.errorMessage {
                    ContentUnavailableView(
                        "Something went wrong",
                        systemImage: "exclamationmark.triangle",
                        description: Text(errorMessage)
                    )
                } else if viewModel.recipes.isEmpty {
                    ContentUnavailableView(
                        "No Recipes Found",
                        systemImage: "magnifyingglass",
                        description: Text("Try adjusting your search or filters.")
                    )
                } else {
                    List(viewModel.recipes) { recipe in
                        NavigationLink(value: recipe) {
                            RecipeCardView(recipe: recipe)
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Recipes")
            .searchable(text: $recipeSearch.query, prompt: "Search recipes")
            .onChange(of: recipeSearch) { _, _ in
                Task {
                    await viewModel.searchRecipes(search: recipeSearch)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingFilters = true
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease")
                    }
                }
            }
            .sheet(isPresented: $showingFilters) {
                RecipeFiltersView(filters: $recipeSearch)
            }
            .navigationDestination(for: Recipe.self) { recipe in
                RecipeDetailView(recipe: recipe)
            }
            .task {
                await viewModel.loadAllRecipes()
            }
        }
    }
}

#Preview("Recipe List") {
    RecipeListView()
}
