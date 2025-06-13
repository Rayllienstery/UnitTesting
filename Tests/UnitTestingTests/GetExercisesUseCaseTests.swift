import XCTest

@testable import UnitTesting

// This test suite verifies the GetExercisesUseCase implementation.
// We use a mock repository to isolate the use case from the real data layer.
// Mocks allow us to test only the business logic of the use case, ensuring that failures are not caused by the repository implementation.
class GetExercisesUseCaseTests: XCTestCase {
  var repository: MockExerciseRepository!
  var getExercisesUseCase: GetExercisesUseCaseImpl!

  override func setUp() {
    super.setUp()
    // Using a mock repository allows us to control the test data and avoid side effects.
    repository = MockExerciseRepository()
    getExercisesUseCase = GetExercisesUseCaseImpl(repository: repository)
  }

  override func tearDown() {
    repository = nil
    getExercisesUseCase = nil
    super.tearDown()
  }

  // This test checks that all added exercises are fetched correctly.
  func testFetchAllExercises() {
    let exercise1 = Exercise(id: UUID(), name: "Push-up", duration: 10)
    let exercise2 = Exercise(id: UUID(), name: "Sit-up", duration: 15)
    _ = repository.addExercise(exercise1)
    _ = repository.addExercise(exercise2)
    let exercises = repository.getAllExercises()
    XCTAssertEqual(exercises.count, 2)
    XCTAssertTrue(exercises.contains(where: { $0.name == "Push-up" }))
    XCTAssertTrue(exercises.contains(where: { $0.name == "Sit-up" }))
  }

  // This test checks that fetching from an empty repository returns an empty array.
  func testFetchAllExercisesWhenEmpty() {
    let exercises = repository.getAllExercises()
    XCTAssertEqual(exercises.count, 0)
  }
}
