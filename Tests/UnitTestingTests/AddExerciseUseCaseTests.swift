import XCTest

@testable import UnitTesting

class AddExerciseUseCaseTests: XCTestCase {
  var repository: ExerciseRepositoryImpl!
  var addExerciseUseCase: AddExerciseUseCase!

  override func setUp() {
    super.setUp()
    repository = ExerciseRepositoryImpl()
    addExerciseUseCase = AddExerciseUseCaseImpl(repository: repository)
  }

  override func tearDown() {
    repository = nil
    addExerciseUseCase = nil
    super.tearDown()
  }

  func testAddExerciseSuccessfully() {
    let exercise = Exercise(id: UUID(), name: "Push-up", duration: 10)
    let result = addExerciseUseCase.execute(exercise: exercise)
    XCTAssertTrue(result)
    XCTAssertEqual(repository.getAllExercises().count, 1)
  }

  func testAddExerciseWithDuplicateIdFails() {
    let id = UUID()
    let exercise1 = Exercise(id: id, name: "Push-up", duration: 10)
    let exercise2 = Exercise(id: id, name: "Sit-up", duration: 15)
    _ = addExerciseUseCase.execute(exercise: exercise1)
    let result = addExerciseUseCase.execute(exercise: exercise2)
    XCTAssertFalse(result)
    XCTAssertEqual(repository.getAllExercises().count, 1)
  }
}
