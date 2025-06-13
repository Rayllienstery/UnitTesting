import Foundation

// import UnitTesting.Domain.Entities

protocol ExerciseViewModelProtocol {
  func addExercise(name: String, duration: Int) -> Bool
  func fetchExercises()
}
