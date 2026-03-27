//
//  RecipeListViewModelTests.swift
//  Recime-CodingChallenge
//
//  Created by Leonardo Medeiros on 26/03/26.
//

import XCTest
@testable import Recime_CodingChallenge

@MainActor
final class RecipeListViewModelTests: XCTestCase {

    func test_loadAllRecipes_success_updatesRecipesAndClearsError() async {
        let mockService = MockRecipeService()
        let expectedRecipes = [Recipe.mock]
        mockService.fetchAllRecipesResult = .success(expectedRecipes)

        let sut = RecipeListViewModel(service: mockService)

        await sut.loadRecipes(search: RecipeSearch())

        XCTAssertTrue(mockService.fetchAllRecipesCalled)
        XCTAssertEqual(sut.recipes, expectedRecipes)
        XCTAssertNil(sut.errorMessage)
        XCTAssertFalse(sut.isLoading)
    }

    func test_loadAllRecipes_failure_setsErrorMessageAndStopsLoading() async {
        let mockService = MockRecipeService()
        mockService.fetchAllRecipesResult = .failure(RecipeServiceAPIError.fileNotFound)

        let sut = RecipeListViewModel(service: mockService)

        await sut.loadRecipes(search: RecipeSearch())

        XCTAssertTrue(mockService.fetchAllRecipesCalled)
        XCTAssertEqual(sut.recipes, [])
        XCTAssertEqual(sut.errorMessage, "Could not find the bundled recipes file.")
        XCTAssertFalse(sut.isLoading)
    }

    func test_searchRecipes_success_updatesRecipesAndPassesSearchObject() async {
        let mockService = MockRecipeService()
        let search = RecipeSearch(
            query: "pasta",
            vegetarianOnly: true,
            servings: 2,
            includedIngredients: ["tomato"],
            excludedIngredients: ["beef"],
            instructionQuery: "boil"
        )
        let expectedRecipes = [Recipe.mock]
        mockService.searchRecipesResult = .success(expectedRecipes)

        let sut = RecipeListViewModel(service: mockService)

        await sut.loadRecipes(search: search)

        XCTAssertTrue(mockService.searchRecipesCalled)
        XCTAssertEqual(mockService.receivedSearch, search)
        XCTAssertEqual(sut.recipes, expectedRecipes)
        XCTAssertNil(sut.errorMessage)
        XCTAssertFalse(sut.isLoading)
    }

    func test_searchRecipes_failure_setsErrorMessageAndStopsLoading() async {
        let mockService = MockRecipeService()
        let search = RecipeSearch(query: "invalid")
        mockService.searchRecipesResult = .failure(RecipeServiceAPIError.fileNotFound)

        let sut = RecipeListViewModel(service: mockService)

        await sut.loadRecipes(search: search)

        XCTAssertTrue(mockService.searchRecipesCalled)
        XCTAssertEqual(mockService.receivedSearch, search)
        XCTAssertEqual(sut.recipes, [])
        XCTAssertEqual(sut.errorMessage, "Could not find the bundled recipes file.")
        XCTAssertFalse(sut.isLoading)
    }

    func test_loadAllRecipes_clearsPreviousErrorBeforeLoading() async {
        let mockService = MockRecipeService()
        mockService.fetchAllRecipesResult = .success([Recipe.mock])

        let sut = RecipeListViewModel(service: mockService)
        sut.errorMessage = "Old error"

        await sut.loadRecipes(search: RecipeSearch())

        XCTAssertNil(sut.errorMessage)
    }

    func test_searchRecipes_clearsPreviousErrorBeforeLoading() async {
        let mockService = MockRecipeService()
        mockService.searchRecipesResult = .success([Recipe.mock])

        let sut = RecipeListViewModel(service: mockService)
        sut.errorMessage = "Old error"

        await sut.loadRecipes(search: RecipeSearch(query: "pasta"))

        XCTAssertNil(sut.errorMessage)
    }
}
