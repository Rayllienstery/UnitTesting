# UnitTesting

## Overview

**UnitTesting** is a modern iOS Swift project demonstrating Clean Architecture and MVVM, with a strong focus on 100% unit test coverage for business logic and ViewModels. This project is designed as a reference for both beginners and experienced developers on how to structure, write, and maintain effective unit tests in Swift.

A minimal example of a testable Swift Package with basic unit and integration tests.

This repository demonstrates:

- how to write clean, minimal unit tests using `XCTest`
- how to structure a testable Swift Package
- a simple integration test example to show how components work together

The goal is to keep the base understandable for beginners without overengineering, while being clean enough to be appreciated by senior developers.

No third-party dependencies. Just Swift and `XCTest`.

---

## Project Structure

```text
Sources/
  UnitTesting/
    Data/
      Repositories/
    Domain/
      Entities/
      UseCases/
    Presentation/
      Features/
        Exercise/
          ViewModel/
            ExerciseViewModel.swift
          View/
            ExerciseListView.swift
      # Shared/
      #   Components/   // For reusable UI elements in the future
Tests/
  UnitTestingTests/
    Integration/
    Support/
Package.swift
```

- **Domain** — Business logic, entities, use cases.
- **Data** — Repositories, data access.
- **Presentation** — Feature-based folders (e.g., Exercise), with ViewModel and View subfolders. Shared/Components for reusable UI.
- **Tests** — Unit and integration tests, mocks.

---

## Architecture Principles

- **Clean Architecture**: Separation into Presentation, Domain, Data layers.
- **MVVM**: ViewModels manage UI state and business logic.
- **Dependency Injection**: For easy mocking and testability.
- **100% Test Coverage**: All ViewModels, UseCases, and Repositories are fully unit tested.

---

## Unit Testing Philosophy

- **Test each unit in isolation**: Use mocks to isolate dependencies.
- **Follow the Given-When-Then pattern**: Improves readability and intent.
- **Name tests descriptively**: `should <expected behavior> when <condition>`.
- **Keep tests independent and repeatable**: No shared state or reliance on external systems.

---

## Unit Tests as a Mandatory Ritual

- **Unit tests are a required ritual before every merge.** Every pull request must include up-to-date and passing unit tests for all affected business logic, ViewModels, use cases, and repositories.
- **Updating tests must cover every function.** If you change, add, or remove any function, you must update or add corresponding tests. No function should exist without relevant test coverage.
- **No merge without green tests.** Code review and CI will block any merge if tests are missing or failing.

---

## Automation Recommendation

- **It is strongly recommended to use automation (CI/CD) for running unit tests and enforcing test coverage before merges.**
- Set up continuous integration to automatically run all tests on every pull request and block merges if tests fail or coverage drops.
- Automation helps maintain code quality, prevents regressions, and enforces the testing culture described above.

---

## Fastlane Pipeline Example

This project uses Fastlane to automate linting and unit testing.

**Fastfile (`fastlane/Fastfile`):**

```ruby
default_platform(:ios)

platform :ios do
  desc "Run SwiftLint and unit tests"
  lane :test_and_lint do
    sh "swiftlint"
    scan(
      scheme: "UnitTesting",
      device: "iPhone 15",
      clean: true,
      code_coverage: true
    )
  end
end
```

**Optional: Pre-push git hook (`.git/hooks/pre-push`):**

```sh
#!/bin/sh
fastlane test_and_lint
if [ $? -ne 0 ]; then
  echo "Fastlane test_and_lint failed. Push aborted."
  exit 1
fi
```

---

## Example: How and Why to Test Each Layer

### 1. ViewModel

**Why:**  
ViewModels contain presentation logic and coordinate business logic via use cases. Testing ensures correct state management and UI logic.

**How:**  

- Use mocks for all dependencies (use cases).
- Test only the ViewModel's logic, not the actual data or business rules.

**Example:**

```swift
// ExerciseViewModelTests.swift

func testAddExerciseSuccessfully() {
    // Given: a ViewModel with a mock repository
    let mockRepository = MockExerciseRepository()
    let viewModel = ExerciseViewModel(
        addExerciseUseCase: AddExerciseUseCaseImpl(repository: mockRepository),
        getExercisesUseCase: GetExercisesUseCaseImpl(repository: mockRepository)
    )
    // When: adding an exercise
    let result = viewModel.addExercise(name: "Push-up", duration: 10)
    // Then: the operation should succeed
    XCTAssertTrue(result)
}
```

---

### 2. UseCase

**Why:**  
UseCases encapsulate business rules and orchestrate data flow between repositories and ViewModels. Testing ensures business logic is correct and edge cases are handled.

**How:**  

- Use mocks for repositories.
- Test all business rules, including error and edge cases.

**Example:**

```swift
// AddExerciseUseCaseTests.swift

func testAddExerciseWithDuplicateIdFails() {
    // Given: a use case with a mock repository
    let repository = MockExerciseRepository()
    let useCase = AddExerciseUseCaseImpl(repository: repository)
    let id = UUID()
    let exercise1 = Exercise(id: id, name: "Push-up", duration: 10)
    let exercise2 = Exercise(id: id, name: "Sit-up", duration: 15)
    _ = useCase.execute(exercise: exercise1)
    // When: adding another exercise with the same id
    let result = useCase.execute(exercise: exercise2)
    // Then: the operation should fail
    XCTAssertFalse(result)
}
```

---

### 3. Repository

**Why:**  
Repositories abstract data storage and retrieval. Testing ensures correct data handling, uniqueness, and retrieval logic.

**How:**  

- Test the real implementation (not a mock).
- Cover all data operations, including duplicates and empty states.

**Example:**

```swift
// ExerciseRepositoryTests.swift

func testAddDuplicateExerciseFails() {
    // Given: a real repository
    let repository = ExerciseRepositoryImpl()
    let id = UUID()
    let exercise1 = Exercise(id: id, name: "Push-up", duration: 10)
    let exercise2 = Exercise(id: id, name: "Sit-up", duration: 15)
    _ = repository.addExercise(exercise1)
    // When: adding a duplicate
    let result = repository.addExercise(exercise2)
    // Then: the operation should fail and only one exercise should exist
    XCTAssertFalse(result)
    XCTAssertEqual(repository.getAllExercises().count, 1)
}
```

---

## How to Run Tests

1. Open the project in Xcode.
2. Select the `UnitTesting` scheme.
3. Press ⌘U or choose Product → Test.

---

## Best Practices

- Mirror the main code structure in your test folders.
- Place all mocks in the `Support` folder, one class per file.
- Use dependency injection for all testable components.
- Write tests for all business logic, ViewModels, and repositories.
- Keep UI tests and SwiftUI previews for UI validation.

---

## Contribution

Feel free to open issues or pull requests for improvements or questions.

---

## License

MIT

---

**This project is an excellent reference for learning and practicing unit testing in modern iOS development.**  
If you need more advanced examples or want to see integration/UI test patterns, let us know!
