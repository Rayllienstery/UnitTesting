import XCTest

@testable import UnitTesting

class GetExercisesUseCaseTests: XCTestCase {
  var repository: ExerciseRepositoryImpl!
  var getExercisesUseCase: GetExercisesUseCase!

  override func setUp() {
    super.setUp()
    repository = ExerciseRepositoryImpl()
    getExercisesUseCase = GetExercisesUseCaseImpl(repository: repository)
  }

  override func tearDown() {
    repository = nil
    getExercisesUseCase = nil
    super.tearDown()
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

  func testFetchAllExercisesWhenEmpty() {
    let exercises = repository.getAllExercises()
    XCTAssertEqual(exercises.count, 0)
  }
}
