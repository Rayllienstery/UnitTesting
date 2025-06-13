import Foundation

/// Model representing an exercise.
struct Exercise {
  /// Unique identifier for the exercise.
  let id: UUID
  /// Name of the exercise.
  let name: String
  /// Duration of the exercise in minutes.
  let duration: Int
}
