import Foundation

/// Defines methods for adding and retrieving exercises.
protocol ExerciseRepository {
  /// Adds an exercise to the repository.
  /// - Parameter exercise: The exercise to add.
  /// - Returns: true if the exercise was added successfully; false if an exercise with the same id already exists.
  func addExercise(_ exercise: Exercise) -> Bool
  /// Returns a list of all exercises.
  /// - Returns: An array of all exercises.
  func getAllExercises() -> [Exercise]
}

/// In-memory implementation of the ExerciseRepository protocol.
class ExerciseRepositoryImpl: ExerciseRepository {
  /// Internal array for storing exercises.
  private var exercises: [Exercise] = []

  /// Adds an exercise if its id is unique.
  /// - Parameter exercise: The exercise to add.
  /// - Returns: true if added successfully; false if the id already exists.
  func addExercise(_ exercise: Exercise) -> Bool {
    if exercises.contains(where: { $0.id == exercise.id }) {
      return false
    }
    exercises.append(exercise)
    return true
  }

  /// Returns all stored exercises.
  /// - Returns: An array of exercises.
  func getAllExercises() -> [Exercise] {
    exercises
  }
}
