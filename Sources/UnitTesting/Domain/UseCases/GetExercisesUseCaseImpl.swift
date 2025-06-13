import Foundation

class GetExercisesUseCaseImpl: GetExercisesUseCase {
  private let repository: ExerciseRepository

  init(repository: ExerciseRepository) {
    self.repository = repository
  }

  func execute() -> [Exercise] {
    repository.getAllExercises()
  }
}
