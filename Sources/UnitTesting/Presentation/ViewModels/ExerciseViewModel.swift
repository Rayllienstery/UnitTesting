import Foundation

class ExerciseViewModel: ExerciseViewModelProtocol {
  private let addExerciseUseCase: AddExerciseUseCase
  private let getExercisesUseCase: GetExercisesUseCase
  private(set) var exercises: [Exercise] = []

  init(addExerciseUseCase: AddExerciseUseCase, getExercisesUseCase: GetExercisesUseCase) {
    self.addExerciseUseCase = addExerciseUseCase
    self.getExercisesUseCase = getExercisesUseCase
  }

  func addExercise(name: String, duration: Int) -> Bool {
    let exercise = Exercise(id: UUID(), name: name, duration: duration)
    return addExerciseUseCase.execute(exercise: exercise)
  }

  func fetchExercises() {
    exercises = getExercisesUseCase.execute()
  }
}
