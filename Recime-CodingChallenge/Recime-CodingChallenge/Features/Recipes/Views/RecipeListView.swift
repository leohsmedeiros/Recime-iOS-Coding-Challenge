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
    @State private var activeFilterCount = 0
    
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
                        ZStack(alignment: .topTrailing) {
                            Image(systemName: "line.3.horizontal.decrease")
                            
                            if activeFilterCount > 0 {
                                Text("\(activeFilterCount)")
                                    .font(.caption2)
                                    .bold()
                                    .foregroundStyle(.white)
                                    .padding(8)
                                    .background(Color.red)
                                    .clipShape(Circle())
                                    .offset(x: 8, y: 8)
                            }
                        }
                    }
                }
            }
            .sheet(isPresented: $showingFilters) {
                RecipeFiltersView(filters: $recipeSearch, activeFilterCount: $activeFilterCount)
            }
            .navigationDestination(for: Recipe.self) { recipe in
                RecipeDetailView(recipe: recipe)
            }
            .task {
                if activeFilterCount > 0 || !recipeSearch.query.isEmpty {
                    await viewModel.searchRecipes(search: recipeSearch)
                } else {
                    await viewModel.loadAllRecipes()
                }
            }
        }
    }
}

#Preview("Recipe List") {
    RecipeListView()
}
