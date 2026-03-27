# ReciMe iOS Coding Challenge

## Setup instructions
1. Open the project in Xcode 16 or later, ensuring the iOS SDK and simulators are properly installed.
2. Clone the repository:
```
git clone https://github.com/your-username/recime-coding-challenge.git
```
3. Build and run on an iOS 26+ simulator
4. No external dependencies are required

## High-level architecture overview
This project uses the MVVM architecture with clear separation of concerns:
- `RecipeService` abstracts data loading
- `RecipeAPI` simulates an API-backed service using bundled JSON
- `RecipeListViewModel` owns loading, search, and filtering logic
- SwiftUI views focus on presentation and user interaction

## Key Design Decisions
- Chose MVVM to keep business logic out of SwiftUI views
- Introduced a RecipeAPI protocol to simulate a real backend and allow easy replacement with a remote implementation
- Used a filter object to centralize search/filter state
- Used a custom search input and filter sheet to allow flexible UI composition and better control over filtering interactions
- Separation of concerns:
```
API → data fetching
Service → filtering logic and get access to api
ViewModel → UI state
```

## Assumptions and Tradeoffs
- Ingredient matching is case-insensitive and substring-based
- Request is done without pagination
- Servings filter is exact rather than range-based
- Images were not part of the requirements
- Persistence/favorites are not included to keep the scope aligned with the challenge, but it would be nice to have

## Known Limitations
- No real backend integration (mock API only)
- No pagination
- No support for large datasets (in-memory filtering)
- Limited validation for user input in filters
- No fuzzy search or typo tolerance
