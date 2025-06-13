import Foundation

/// Protocol for the use case of retrieving all exercises.
protocol GetExercisesUseCase {
  /// Returns a list of all exercises.
  /// - Returns: An array of exercises.
  func execute() -> [Exercise]
}

/// Implementation of the use case for retrieving all exercises.
class GetExercisesUseCaseImpl: GetExercisesUseCase {
  /// The exercise repository.
  private let repository: ExerciseRepository

  /// Initializes with a repository.
  init(repository: ExerciseRepository) {
    self.repository = repository
  }

  /// Retrieves all exercises from the repository.
  func execute() -> [Exercise] {
    repository.getAllExercises()
  }
}
