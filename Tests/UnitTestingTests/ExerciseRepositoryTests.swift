import XCTest

@testable import UnitTesting

class ExerciseRepositoryTests: XCTestCase {
  var repository: ExerciseRepositoryImpl!

  override func setUp() {
    super.setUp()
    repository = ExerciseRepositoryImpl()
  }

  override func tearDown() {
    repository = nil
    super.tearDown()
  }

  func testAddExerciseSuccessfully() {
    let exercise = Exercise(id: UUID(), name: "Push-up", duration: 10)
    let result = repository.addExercise(exercise)
    XCTAssertTrue(result)
    XCTAssertEqual(repository.getAllExercises().count, 1)
  }

  func testAddDuplicateExerciseFails() {
    let id = UUID()
    let exercise1 = Exercise(id: id, name: "Push-up", duration: 10)
    let exercise2 = Exercise(id: id, name: "Sit-up", duration: 15)
    _ = repository.addExercise(exercise1)
    let result = repository.addExercise(exercise2)
    XCTAssertFalse(result)
    XCTAssertEqual(repository.getAllExercises().count, 1)
  }

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

  func testFetchFromEmptyRepository() {
    let exercises = repository.getAllExercises()
    XCTAssertTrue(exercises.isEmpty)
  }
}
