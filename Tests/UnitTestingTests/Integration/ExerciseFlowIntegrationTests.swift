import XCTest

@testable import UnitTesting

final class ExerciseFlowIntegrationTests: XCTestCase {
  func test_add_and_fetch_exercise_flow() {
    // Arrange: use real implementations
    let repository = ExerciseRepositoryImpl()
    let addUseCase = AddExerciseUseCaseImpl(repository: repository)
    let getUseCase = GetExercisesUseCaseImpl(repository: repository)
    let viewModel = ExerciseViewModel(addExerciseUseCase: addUseCase, getExercisesUseCase: getUseCase)

    // Act: add an exercise via ViewModel
    let addResult = viewModel.addExercise(name: "Push Ups", duration: 30)
    viewModel.fetchExercises()
    let exercises = viewModel.exercises

    // Assert: verify that the exercise was added and fetched correctly
    XCTAssertTrue(addResult, "Exercise should be added successfully")
    XCTAssertEqual(exercises.count, 1, "There should be one exercise")
    XCTAssertEqual(exercises.first?.name, "Push Ups")
    XCTAssertEqual(exercises.first?.duration, 30)
  }
}
