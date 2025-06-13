import Foundation

protocol ExerciseRepository {
  func addExercise(_ exercise: Exercise) -> Bool
  func getAllExercises() -> [Exercise]
}
