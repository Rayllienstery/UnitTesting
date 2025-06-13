import Foundation

protocol AddExerciseUseCase {
  init(repository: ExerciseRepository)
  func execute(exercise: Exercise) -> Bool
}

class AddExerciseUseCaseImpl: AddExerciseUseCase {
  private let repository: ExerciseRepository

  required init(repository: ExerciseRepository) {
    self.repository = repository
  }

  func execute(exercise: Exercise) -> Bool {
    return repository.addExercise(exercise)
  }
}
