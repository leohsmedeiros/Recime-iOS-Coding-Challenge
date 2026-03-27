//
//  RecipeServiceImplTests.swift
//  Recime-CodingChallenge
//
//  Created by Leonardo Medeiros on 26/03/26.
//


import XCTest
@testable import Recime_CodingChallenge

@MainActor
final class RecipeServiceImplTests: XCTestCase {

    private var sut: RecipeServiceImpl!

    override func setUp() {
        super.setUp()
        sut = RecipeServiceImpl(api: MockRecipeAPI())
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_fetchAllRecipes_returnsAllRecipesCorrectly() async throws {
        let recipes = try await sut.fetchAllRecipes()

        XCTAssertEqual(recipes.count, 3)
        XCTAssertEqual(recipes.map { $0.title }, [
            "Vegetarian Pasta",
            "Grilled Chicken Salad",
            "Vegan Buddha Bowl"
        ])
    }

    func test_searchRecipes_withEmptySearch_returnsAllRecipes() async throws {
        let search = RecipeSearch()

        let recipes = try await sut.searchRecipes(search)

        XCTAssertEqual(recipes.count, 3)
    }

    func test_searchRecipes_filtersByQuery() async throws {
        let search = RecipeSearch(query: "pasta")

        let recipes = try await sut.searchRecipes(search)

        XCTAssertEqual(recipes.count, 1)
        XCTAssertEqual(recipes.first?.title, "Vegetarian Pasta")
    }

    func test_searchRecipes_filtersByServings() async throws {
        let search = RecipeSearch(servings: 1)

        let recipes = try await sut.searchRecipes(search)

        XCTAssertEqual(recipes.count, 1)
        XCTAssertEqual(recipes.first?.title, "Vegetarian Pasta")
    }

    func test_searchRecipes_filtersByIncludedIngredients() async throws {
        let search = RecipeSearch(includedIngredients: ["garlic"])

        let recipes = try await sut.searchRecipes(search)

        XCTAssertEqual(recipes.count, 1)
        XCTAssertEqual(Set(recipes.map(\.title)), ["Vegetarian Pasta"])
    }

    func test_searchRecipes_filtersByExcludedIngredients() async throws {
        let search = RecipeSearch(excludedIngredients: ["chicken"])

        let recipes = try await sut.searchRecipes(search)

        XCTAssertEqual(recipes.count, 2)
        XCTAssertFalse(recipes.contains { $0.title == "Chicken Curry" })
    }

    func test_searchRecipes_filtersByInstructionQuery() async throws {
        let search = RecipeSearch(instructionQuery: "Boil the pasta")

        let recipes = try await sut.searchRecipes(search)

        XCTAssertEqual(recipes.count, 1)
        XCTAssertEqual(recipes.first?.title, "Vegetarian Pasta")
    }

    func test_searchRecipes_filtersByVegetarianOnly_returnsOnlyStrictVegetarianRecipes() async throws {
        let search = RecipeSearch(vegetarianOnly: true)

        let recipes = try await sut.searchRecipes(search)

        XCTAssertEqual(recipes.count, 1)
        XCTAssertEqual(recipes.first?.title, "Vegetarian Pasta")
    }

    func test_searchRecipes_appliesCombinedFilters() async throws {
        let search = RecipeSearch(
            query: "pasta",
            vegetarianOnly: true,
            servings: 1,
            includedIngredients: ["tomato"],
            excludedIngredients: ["chicken"],
            instructionQuery: "boil"
        )

        let recipes = try await sut.searchRecipes(search)

        XCTAssertEqual(recipes.count, 1)
        XCTAssertEqual(recipes.first?.title, "Vegetarian Pasta")
    }
}
