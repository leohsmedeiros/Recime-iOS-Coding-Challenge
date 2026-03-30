//
//  RecipeServiceImplTests.swift
//  Recime-CodingChallenge
//
//  Created by Leonardo Medeiros on 26/03/26.
//

import Testing
@testable import Recime_CodingChallenge

@Suite struct RecipeServiceImplTests {
    private let sut = RecipeServiceImpl(api: MockRecipeAPI())

    @Test func searchRecipes_withEmptySearch_returnsAllRecipes() async throws {
        let recipes = try await sut.searchRecipes(RecipeSearch())

        #expect(recipes.count == 3)
        #expect(recipes.map(\.title) == [
            "Vegetarian Pasta",
            "Grilled Chicken Salad",
            "Vegan Buddha Bowl"
        ])
    }

    @Test func searchRecipes_filtersByQuery() async throws {
        let recipes = try await sut.searchRecipes(RecipeSearch(query: "pasta"))

        #expect(recipes.count == 1)
        #expect(recipes.first?.title == "Vegetarian Pasta")
    }

    @Test func searchRecipes_filtersByServings() async throws {
        let recipes = try await sut.searchRecipes(RecipeSearch(servings: 1))

        #expect(recipes.count == 1)
        #expect(recipes.first?.title == "Vegetarian Pasta")
    }

    @Test func searchRecipes_filtersByIncludedIngredients() async throws {
        let recipes = try await sut.searchRecipes(RecipeSearch(includedIngredients: ["garlic"]))

        #expect(recipes.count == 1)
        #expect(recipes.first?.title == "Vegetarian Pasta")
    }

    @Test func searchRecipes_filtersByExcludedIngredients() async throws {
        let recipes = try await sut.searchRecipes(RecipeSearch(excludedIngredients: ["chicken"]))

        #expect(recipes.count == 2)
        #expect(!recipes.contains { $0.title == "Grilled Chicken Salad" })
    }

    @Test func searchRecipes_filtersByInstructionQuery() async throws {
        let recipes = try await sut.searchRecipes(RecipeSearch(instructionQuery: "Boil the pasta"))

        #expect(recipes.count == 1)
        #expect(recipes.first?.title == "Vegetarian Pasta")
    }

    @Test func searchRecipes_filtersByVegetarianOnly() async throws {
        let recipes = try await sut.searchRecipes(RecipeSearch(vegetarianOnly: true))

        #expect(recipes.count == 1)
        #expect(recipes.first?.title == "Vegetarian Pasta")
    }

    @Test func searchRecipes_appliesCombinedFilters() async throws {
        let search = RecipeSearch(
            query: "pasta",
            vegetarianOnly: true,
            servings: 1,
            includedIngredients: ["tomato"],
            excludedIngredients: ["chicken"],
            instructionQuery: "boil"
        )

        let recipes = try await sut.searchRecipes(search)

        #expect(recipes.count == 1)
        #expect(recipes.first?.title == "Vegetarian Pasta")
    }
}
