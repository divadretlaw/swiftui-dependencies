import SwiftUI

struct TaskButton<Label>: View where Label: View {
    var action: @MainActor @Sendable () async -> Void
    var label: (Bool) -> Label
    
    @State private var isRunning = false
    @State private var task: Task<Void, Never>?
    
    init(
        action: @MainActor @Sendable @escaping () async -> Void,
        @ViewBuilder label: @escaping (_ isRunning: Bool) -> Label
    ) {
        self.action = action
        self.label = label
    }
    
    var body: some View {
        Button {
            self.isRunning = true
            self.task = Task {
                await action()
                self.isRunning = false
            }
        } label: {
            label(isRunning)
        }
        .animation(.default, value: isRunning)
        .disabled(isRunning)
        .onDisappear {
            task?.cancel()
        }
    }
}

extension TaskButton where Label == Text {
    init(_ label: String, action: @MainActor @Sendable @escaping () async -> Void) {
        self.action = action
        self.label = { _ in Text(label) }
    }
}

#Preview {
    TaskButton {
        try? await Task.sleep(nanoseconds: 2 * NSEC_PER_SEC)
    } label: { isRunning in
        if isRunning {
            ProgressView()
        } else {
            Text("Start")
        }
    }
}
