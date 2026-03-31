# ReciMe iOS Coding Challenge

## Setup Instructions
1. Clone the repository:
```
git clone https://github.com/leohsmedeiros/Recime-iOS-Coding-Challenge.git
```
2. Open `Recime-CodingChallenge.xcodeproj` in Xcode 26 or later.
3. Build and run on an iOS 26+ simulator or device. No external dependencies are required.

---

## High-level architecture overview
This project uses the MVVM architecture with clear separation of concerns:
```
Domain          ← protocols and models (no platform dependencies)
  ├─ RecipeAPI          protocol – contract for data fetching
  ├─ RecipeService      protocol – contract for search/filter operations
  ├─ Recipe             model
  ├─ RecipeSearch       model (Equatable) – unified search + filter state
  └─ DietaryAttribute   enum

Data            ← concrete implementations of domain protocols
  ├─ LocalRecipeAPI     reads recipes.json from the app bundle
  ├─ RecipeServiceImpl  six filter predicates injected with RecipeAPI
  └─ RecipeServiceAPIError

Features        ← MVVM, one screen
  ├─ RecipeListViewModel   (@Observable, @MainActor loadRecipes)
  ├─ RecipeListView        LazyVGrid + .task(id:) for reactive search
  ├─ RecipeCardView        hero gradient card with floating dietary chips
  ├─ RecipeDetailView      progressive-immersion hero + sliding content sheet
  ├─ RecipeFiltersView     custom scroll form with FloatingLabelTextField
  └─ Components/
       ├─ SelectionChip
       ├─ FloatingLabelTextField
       └─ AppButtonStyles

DesignSystem    ← token files (no views, no logic)
  ├─ AppColors      Color.App.* — adaptive light/dark via UIColor(dynamicProvider:)
  ├─ AppTypography  Font.App.* — Noto Serif + Manrope scale + eyebrowStyle()
  ├─ AppSpacing     AppSpacing.* / AppRadius.*
  └─ AppElevation   AmbientShadow · GhostBorder · FrostedGlass · GlassNavigationBar
```

---

## Key Design Decisions
- Chose MVVM to separate business logic from SwiftUI views and enable a reactive data flow.
- Introduced a RecipeAPI protocol to simulate a real backend and allow easy replacement with a remote implementation
- Used a RecipeSearch object to centralize search/filter state
- Used a custom search input and filter sheet to allow flexible UI composition and better control over filtering interactions
- Separation of concerns:
```
API → data fetching
Service → filtering logic and get access to api
ViewModel → UI state
```
- Protocol-based dependency injection
Both `RecipeServiceImpl` and `RecipeListViewModel` accept their dependencies through protocol parameters with production defaults:
```swift
RecipeServiceImpl(api: RecipeAPI = LocalRecipeAPI())
RecipeListViewModel(service: RecipeService = RecipeServiceImpl())
```
This means tests can pass lightweight mock objects without any swizzling or global state.
- Adaptive dark mode — no asset catalog required

---

## Assumptions and Trade-offs
- **Ingredient matching** is case-insensitive substring search.
- **Servings filter** is exact match, not a range.
- **Instruction filter** matches any step that contains the query as a substring.
- **No pagination** — full dataset is loaded in memory and filtered client-side.
- **No images** — recipe cards use a branded gradient as a stand-in; the `Recipe` model has no image field in the provided JSON.
- **No persistence or favourites** — out of scope for the challenge but the domain layer is ready for it.
- **No remote backend** — `LocalRecipeAPI` reads `recipes.json` from the bundle. Replacing it with a `URLSession`-backed implementation only requires conforming to `RecipeAPI`.

---

## Known Limitations
- No real backend integration (mock API only)
- No pagination
- No support for large datasets (in-memory filtering)
- Limited validation for user input in filters
- No fuzzy search or typo tolerance
