import SwiftUI

struct ExerciseListView: View {
  let model: ExerciseViewModel
  @State private var name: String = ""
  @State private var duration: String = ""
  @FocusState private var isNameFocused: Bool

  var body: some View {
    NavigationStack {
      VStack(spacing: 16) {
        List(model.exercises, id: \.id) { exercise in
          VStack(alignment: .leading) {
            Text(exercise.name)
              .font(.headline)
              .accessibilityLabel("Exercise name: \(exercise.name)")
            Text("Duration: \(exercise.duration) min")
              .font(.subheadline)
              .foregroundColor(.secondary)
              .accessibilityLabel("Duration: \(exercise.duration) minutes")
          }
        }
        .listStyle(.plain)
        .accessibilityLabel("Exercises list")

        VStack(spacing: 8) {
          TextField("Exercise name", text: $name)
            .textFieldStyle(.roundedBorder)
            .accessibilityLabel("Exercise name input")
            .focused($isNameFocused)
          TextField("Duration (min)", text: $duration)
            #if os(iOS) || os(visionOS)
              .keyboardType(.numberPad)
            #endif
            .textFieldStyle(.roundedBorder)
            .accessibilityLabel("Duration input")
          Button("Add Exercise") {
            addExercise()
          }
          .buttonStyle(.borderedProminent)
          .accessibilityLabel("Add exercise button")
        }
        .padding(.horizontal)
      }
      .navigationTitle("Exercises")
      .onAppear { model.fetchExercises() }
    }
  }

  private func addExercise() {
    guard !name.isEmpty, let minutes = Int(duration), minutes > 0 else { return }
    if model.addExercise(name: name, duration: minutes) {
      name = ""
      duration = ""
      isNameFocused = true
      model.fetchExercises()
    }
  }
}

#Preview {
  // In-memory repository for preview
  let repo = ExerciseRepositoryImpl()
  _ = repo.addExercise(Exercise(id: UUID(), name: "Push-up", duration: 10))
  _ = repo.addExercise(Exercise(id: UUID(), name: "Sit-up", duration: 15))
  let model = ExerciseViewModel(
    addExerciseUseCase: AddExerciseUseCaseImpl(repository: repo),
    getExercisesUseCase: GetExercisesUseCaseImpl(repository: repo)
  )
  return ExerciseListView(model: model)
}
