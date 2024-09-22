import SwiftUI
import Dependencies

struct ObservationView: View {
    @Environment(\.dependencyContext) private var context
    
    @DependencyState private var model: Model
    
    var body: some View {
        List {
            LabeledContent("Context", value: context.description)
            
            Section {
                if let user = model.loggedInUser {
                    LabeledContent("User", value: user)
                    Button("Logout", role: .destructive) {
                        model.logout()
                    }
                } else {
                    TaskButton("Login") {
                        await model.login()
                    }
                }
            }
        }
        .navigationTitle("Observation")
        .animation(.default, value: model.loggedInUser)
        .modifier(DemoViewModifier())
    }
}

#Preview {
    NavigationStack {
        ObservationView()
    }
}
