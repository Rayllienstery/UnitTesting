import XCTest

@testable import UnitTesting

class ExerciseViewModelTests: XCTestCase {
  var viewModel: ExerciseViewModel!
  var mockAddExerciseUseCase: MockAddExerciseUseCase!
  var mockGetExercisesUseCase: MockGetExercisesUseCase!

  override func setUp() {
    super.setUp()
    let mockRepository = MockExerciseRepository()
    mockAddExerciseUseCase = MockAddExerciseUseCase(repository: mockRepository)
    mockGetExercisesUseCase = MockGetExercisesUseCase()
    viewModel = ExerciseViewModel(
      addExerciseUseCase: mockAddExerciseUseCase, getExercisesUseCase: mockGetExercisesUseCase)
  }

  override func tearDown() {
    viewModel = nil
    mockAddExerciseUseCase = nil
    mockGetExercisesUseCase = nil
    super.tearDown()
  }

  func testAddExerciseSuccessfully() {
    let result = viewModel.addExercise(name: "Push-up", duration: 10)
    XCTAssertTrue(result)
  }

  func testFetchExercises() {
    let exercise1 = Exercise(id: UUID(), name: "Push-up", duration: 10)
    let exercise2 = Exercise(id: UUID(), name: "Sit-up", duration: 15)
    mockGetExercisesUseCase.exercises = [exercise1, exercise2]
    viewModel.fetchExercises()
    XCTAssertEqual(viewModel.exercises.count, 2)
    XCTAssertEqual(viewModel.exercises[0].name, "Push-up")
    XCTAssertEqual(viewModel.exercises[1].name, "Sit-up")
  }
}

// Mock Use Cases
class MockAddExerciseUseCase: AddExerciseUseCase {
  private let repository: ExerciseRepository

  required init(repository: ExerciseRepository) {
    self.repository = repository
  }

  func execute(exercise: Exercise) -> Bool {
    return true
  }
}

class MockGetExercisesUseCase: GetExercisesUseCase {
  var exercises: [Exercise] = []
  func execute() -> [Exercise] {
    return exercises
  }
}
