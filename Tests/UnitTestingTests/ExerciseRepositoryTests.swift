import XCTest

@testable import UnitTesting

// This test suite verifies the real implementation of ExerciseRepository.
// Here, we do not use mocks because we want to test the actual data storage and retrieval logic.
// This is important to ensure that the repository works as expected in real scenarios.
class ExerciseRepositoryTests: XCTestCase {
  var repository: ExerciseRepositoryImpl!

  override func setUp() {
    super.setUp()
    // We use the real repository implementation to test its actual behavior.
    repository = ExerciseRepositoryImpl()
  }

  override func tearDown() {
    repository = nil
    super.tearDown()
  }

  // This test checks that a new exercise can be added successfully.
  func testAddExerciseSuccessfully() {
    let exercise = Exercise(id: UUID(), name: "Push-up", duration: 10)
    let result = repository.addExercise(exercise)
    XCTAssertTrue(result)
    XCTAssertEqual(repository.getAllExercises().count, 1)
  }

  // This test checks that adding a duplicate exercise (same id) fails.
  func testAddDuplicateExerciseFails() {
    let id = UUID()
    let exercise1 = Exercise(id: id, name: "Push-up", duration: 10)
    let exercise2 = Exercise(id: id, name: "Sit-up", duration: 15)
    _ = repository.addExercise(exercise1)
    let result = repository.addExercise(exercise2)
    XCTAssertFalse(result)
    XCTAssertEqual(repository.getAllExercises().count, 1)
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
  func testFetchFromEmptyRepository() {
    let exercises = repository.getAllExercises()
    XCTAssertTrue(exercises.isEmpty)
  }
}
