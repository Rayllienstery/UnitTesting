import XCTest

@testable import UnitTesting

// This test suite verifies the AddExerciseUseCase implementation.
// We use a mock repository to isolate the use case from the real data layer.
// Mocks allow us to test only the business logic of the use case, ensuring that failures are not caused by the repository implementation.
class AddExerciseUseCaseTests: XCTestCase {
  var repository: MockExerciseRepository!
  var addExerciseUseCase: AddExerciseUseCaseImpl!

  override func setUp() {
    super.setUp()
    // Using a mock repository allows us to control the test data and avoid side effects.
    repository = MockExerciseRepository()
    addExerciseUseCase = AddExerciseUseCaseImpl(repository: repository)
  }

  override func tearDown() {
    repository = nil
    addExerciseUseCase = nil
    super.tearDown()
  }

  // This test checks that a new exercise can be added successfully.
  func testAddExerciseSuccessfully() {
    let exercise = Exercise(id: UUID(), name: "Push-up", duration: 10)
    let result = addExerciseUseCase.execute(exercise: exercise)
    XCTAssertTrue(result)
    XCTAssertEqual(repository.getAllExercises().count, 1)
  }

  // This test checks that adding an exercise with a duplicate id fails.
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
