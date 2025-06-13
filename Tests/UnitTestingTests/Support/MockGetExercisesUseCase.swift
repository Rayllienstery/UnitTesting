import Foundation

@testable import UnitTesting

class MockGetExercisesUseCase: GetExercisesUseCase {
  var exercises: [Exercise] = []

  func execute() -> [Exercise] {
    exercises
  }
}
