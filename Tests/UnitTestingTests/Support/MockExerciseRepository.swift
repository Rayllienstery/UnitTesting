import Foundation

@testable import UnitTesting

// Ensure the correct import of the ExerciseRepository protocol
class MockExerciseRepository: ExerciseRepository {
  private var exercises: [Exercise] = []

  func addExercise(_ exercise: Exercise) -> Bool {
    if exercises.contains(where: { $0.id == exercise.id }) {
      return false
    }
    exercises.append(exercise)
    return true
  }

  func getAllExercises() -> [Exercise] {
    return exercises
  }
}
