import SwiftUI

/// Protocol for the ViewModel managing exercises.
protocol ExerciseViewModelProtocol: Observable, AnyObject {
  /// Adds an exercise by name and duration.
  /// - Parameters:
  ///   - name: The name of the exercise.
  ///   - duration: The duration of the exercise.
  /// - Returns: true if added successfully.
  func addExercise(name: String, duration: Int) -> Bool
  /// Loads the list of exercises.
  func fetchExercises()
}

/// ViewModel for managing exercises and interacting with use cases.
@Observable
class ExerciseViewModel: ExerciseViewModelProtocol {
  /// Use case for adding an exercise.
  private let addExerciseUseCase: AddExerciseUseCase
  /// Use case for retrieving exercises.
  private let getExercisesUseCase: GetExercisesUseCase
  /// List of exercises, read-only.
  private(set) var exercises: [Exercise] = []

  /// Initializes with use cases for adding and retrieving exercises.
  init(addExerciseUseCase: AddExerciseUseCase, getExercisesUseCase: GetExercisesUseCase) {
    self.addExerciseUseCase = addExerciseUseCase
    self.getExercisesUseCase = getExercisesUseCase
  }

  /// Adds an exercise by name and duration.
  /// - Parameters:
  ///   - name: The name of the exercise.
  ///   - duration: The duration of the exercise.
  /// - Returns: true if added successfully.
  func addExercise(name: String, duration: Int) -> Bool {
    let exercise = Exercise(id: UUID(), name: name, duration: duration)
    return addExerciseUseCase.execute(exercise: exercise)
  }

  /// Loads the list of exercises from the use case.
  func fetchExercises() {
    exercises = getExercisesUseCase.execute()
  }
}
