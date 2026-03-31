//
//  RecipeListView.swift
//  Recime-CodingChallenge
//
//  Created by Leonardo Medeiros on 25/03/26.
//

import SwiftUI

struct RecipeListView: View {
    @State private var viewModel = RecipeListViewModel()
    @State private var recipeSearch = RecipeSearch()
    @State private var showingFilters = false
    
    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    private var activeFilterCount: Int {
        viewModel.computeActiveFilterCount(search: recipeSearch)
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.App.surface.ignoresSafeArea()

                Group {
                    if viewModel.isLoading {
                        ProgressView()
                            .tint(Color.App.primary)
                    } else if let errorMessage = viewModel.errorMessage {
                        ContentUnavailableView(
                            "Something went wrong",
                            systemImage: "exclamationmark.triangle",
                            description: Text(errorMessage)
                                .font(.App.bodySm)
                        )
                    } else if viewModel.recipes.isEmpty {
                        ContentUnavailableView(
                            "No Recipes Found",
                            systemImage: "magnifyingglass",
                            description: Text("Try adjusting your search or filters.")
                                .font(.App.bodySm)
                        )
                    } else {
                        ScrollView {
                            LazyVGrid(columns: columns, spacing: AppSpacing.md) {
                                ForEach(viewModel.recipes) { recipe in
                                    NavigationLink(value: recipe) {
                                        RecipeCardView(recipe: recipe)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                            .padding(.horizontal, AppSpacing.lg)
                            .padding(.vertical, AppSpacing.md)
                        }
                    }
                }
            }
            .searchable(text: $recipeSearch.query, placement: .navigationBarDrawer, prompt: "Search recipes")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingFilters = true
                    } label: {
                        ZStack(alignment: .topTrailing) {
                            Image(systemName: "line.3.horizontal.decrease")
                                .foregroundStyle(Color.App.primary)

                            if activeFilterCount > 0 {
                                Text("\(activeFilterCount)")
                                    .font(.App.labelSm)
                                    .bold()
                                    .foregroundStyle(Color.App.onSecondary)
                                    .padding(5)
                                    .background(Color.App.secondary)
                                    .clipShape(Circle())
                                    .offset(x: 8, y: -8)
                            }
                        }
                    }
                    .padding(5)
                }
            }
            .sheet(isPresented: $showingFilters) {
                RecipeFiltersView(filters: $recipeSearch)
            }
            .navigationDestination(for: Recipe.self) { recipe in
                RecipeDetailView(recipe: recipe)
            }
            .task(id: recipeSearch) {
                do {
                    try await Task.sleep(nanoseconds: 400_000_000)

                    if Task.isCancelled { return }

                    await viewModel.loadRecipes(search: recipeSearch)
                } catch {
                    // ignore cancellation errors
                }
            }
        }
    }
}

// MARK: - Preview

#Preview("Recipe List") {
    RecipeListView()
}
