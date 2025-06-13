import Foundation

/// Protocol for the use case of adding an exercise.
protocol AddExerciseUseCase {
  /// Initializes with an exercise repository.
  /// - Parameter repository: The exercise repository.
  init(repository: ExerciseRepository)
  /// Executes the addition of an exercise.
  /// - Parameter exercise: The exercise to add.
  /// - Returns: true if added successfully; false if the id already exists.
  func execute(exercise: Exercise) -> Bool
}

/// Implementation of the use case for adding an exercise.
class AddExerciseUseCaseImpl: AddExerciseUseCase {
  /// The exercise repository.
  private let repository: ExerciseRepository

  /// Initializes with a repository.
  required init(repository: ExerciseRepository) {
    self.repository = repository
  }

  /// Adds an exercise via the repository.
  func execute(exercise: Exercise) -> Bool {
    repository.addExercise(exercise)
  }
}
