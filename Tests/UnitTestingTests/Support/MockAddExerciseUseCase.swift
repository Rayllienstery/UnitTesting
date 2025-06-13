import Foundation

@testable import UnitTesting

class MockAddExerciseUseCase: AddExerciseUseCase {
  private let repository: ExerciseRepository

  required init(repository: ExerciseRepository) {
    self.repository = repository
  }

  func execute(exercise: Exercise) -> Bool {
    true
  }
}
