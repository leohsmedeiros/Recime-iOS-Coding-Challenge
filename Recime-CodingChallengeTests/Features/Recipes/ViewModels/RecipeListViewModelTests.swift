//
//  RecipeListViewModelTests.swift
//  Recime-CodingChallenge
//
//  Created by Leonardo Medeiros on 26/03/26.
//

import Testing
@testable import Recime_CodingChallenge

@Suite struct RecipeListViewModelTests {

    // MARK: - loadRecipes
    // loadRecipes is @MainActor on the ViewModel, so tests calling it must be too.

    @Test @MainActor
    func loadRecipes_onSuccess_updatesRecipesAndClearsError() async {
        let mockService = MockRecipeService()
        mockService.searchRecipesResult = .success([Recipe.mock])
        let sut = RecipeListViewModel(service: mockService)

        await sut.loadRecipes(search: RecipeSearch())

        #expect(sut.recipes == [Recipe.mock])
        #expect(sut.errorMessage == nil)
        #expect(!sut.isLoading)
    }

    @Test @MainActor
    func loadRecipes_onFailure_setsErrorMessageAndStopsLoading() async {
        let mockService = MockRecipeService()
        mockService.searchRecipesResult = .failure(RecipeServiceAPIError.fileNotFound)
        let sut = RecipeListViewModel(service: mockService)

        await sut.loadRecipes(search: RecipeSearch())

        #expect(sut.recipes.isEmpty)
        #expect(sut.errorMessage == "Could not find the bundled recipes file.")
        #expect(!sut.isLoading)
    }

    @Test @MainActor
    func loadRecipes_forwardsSearchObjectToService() async {
        let mockService = MockRecipeService()
        let search = RecipeSearch(
            query: "pasta",
            vegetarianOnly: true,
            servings: 2,
            includedIngredients: ["tomato"],
            excludedIngredients: ["beef"],
            instructionQuery: "boil"
        )
        mockService.searchRecipesResult = .success([Recipe.mock])
        let sut = RecipeListViewModel(service: mockService)

        await sut.loadRecipes(search: search)

        #expect(mockService.searchRecipesCalled)
        #expect(mockService.receivedSearch == search)
        #expect(sut.recipes == [Recipe.mock])
        #expect(sut.errorMessage == nil)
        #expect(!sut.isLoading)
    }

    @Test @MainActor
    func loadRecipes_withFilter_failure_setsErrorMessageAndStopsLoading() async {
        let mockService = MockRecipeService()
        let search = RecipeSearch(query: "invalid")
        mockService.searchRecipesResult = .failure(RecipeServiceAPIError.fileNotFound)
        let sut = RecipeListViewModel(service: mockService)

        await sut.loadRecipes(search: search)

        #expect(mockService.searchRecipesCalled)
        #expect(mockService.receivedSearch == search)
        #expect(sut.recipes.isEmpty)
        #expect(sut.errorMessage == "Could not find the bundled recipes file.")
        #expect(!sut.isLoading)
    }

    @Test @MainActor
    func loadRecipes_clearsPreviousErrorBeforeLoading() async {
        let mockService = MockRecipeService()
        mockService.searchRecipesResult = .success([Recipe.mock])
        let sut = RecipeListViewModel(service: mockService)
        sut.errorMessage = "Old error"

        await sut.loadRecipes(search: RecipeSearch())

        #expect(sut.errorMessage == nil)
    }

    // MARK: - computeActiveFilterCount
    // Pure computation — no actor isolation needed.

    @Test func computeActiveFilterCount_whenNoFilters_returnsZero() {
        let sut = RecipeListViewModel(service: MockRecipeService())

        #expect(sut.computeActiveFilterCount(search: RecipeSearch()) == 0)
    }

    @Test func computeActiveFilterCount_whenOnlyQueryIsSet_returnsZero() {
        let sut = RecipeListViewModel(service: MockRecipeService())

        #expect(sut.computeActiveFilterCount(search: RecipeSearch(query: "pasta")) == 0)
    }

    @Test func computeActiveFilterCount_whenMultipleFiltersSet_returnsCorrectCount() {
        let sut = RecipeListViewModel(service: MockRecipeService())
        let search = RecipeSearch(
            vegetarianOnly: true,
            servings: 2,
            includedIngredients: ["tomato"],
            excludedIngredients: ["beef"],
            instructionQuery: "boil"
        )

        #expect(sut.computeActiveFilterCount(search: search) == 5)
    }

    @Test func computeActiveFilterCount_whenInstructionQueryIsWhitespace_returnsZero() {
        let sut = RecipeListViewModel(service: MockRecipeService())

        #expect(sut.computeActiveFilterCount(search: RecipeSearch(instructionQuery: "   ")) == 0)
    }
}
