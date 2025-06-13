import XCTest

@testable import UnitTesting

// This test suite verifies the behavior of ExerciseViewModel.
// We use mocks to isolate the ViewModel from real data sources and business logic implementations.
// Mocks allow us to test only the ViewModel logic, ensuring that failures are not caused by other layers.
// This is a best practice for unit testing: test one unit in isolation.
//
// Note: The ViewModel should not be responsible for the order of exercises unless it is a UI-specific requirement.
// If order is important, it should be handled by the UseCase or Repository layer according to business rules.
class ExerciseViewModelTests: XCTestCase {
  // The ViewModel under test. It manages the presentation logic for exercises.
  var viewModel: ExerciseViewModel!

  // setUp is called before each test method. We use it to create a fresh ViewModel instance with a mock repository.
  override func setUp() {
    super.setUp()
    // We use a mock repository to avoid side effects and to control test data.
    // This ensures our tests are reliable and repeatable.
    let mockRepository = MockExerciseRepository()
    viewModel = ExerciseViewModel(
      addExerciseUseCase: AddExerciseUseCaseImpl(repository: mockRepository),
      getExercisesUseCase: GetExercisesUseCaseImpl(repository: mockRepository)
    )
  }

  // tearDown is called after each test method. We use it to clean up.
  override func tearDown() {
    viewModel = nil
    super.tearDown()
  }

  // This test checks that adding an exercise via the ViewModel returns true (success).
  // We use a mock repository, so we know the add operation should succeed for a new exercise.
  func testAddExerciseSuccessfully() {
    let result = viewModel.addExercise(name: "Push-up", duration: 10)
    XCTAssertTrue(result)
  }

  // This test checks that after adding two exercises, both are present in the fetched list.
  // We do not check the order, because ViewModel should not be responsible for ordering unless explicitly required.
  // The test verifies that the ViewModel correctly delegates fetching to the use case and exposes the data.
  func testFetchExercises() {
    _ = viewModel.addExercise(name: "Push-up", duration: 10)
    _ = viewModel.addExercise(name: "Sit-up", duration: 15)
    viewModel.fetchExercises()
    let names = viewModel.exercises.map { $0.name }
    XCTAssertTrue(names.contains("Push-up"))
    XCTAssertTrue(names.contains("Sit-up"))
    XCTAssertEqual(viewModel.exercises.count, 2)
  }
}
