import SwiftUI
import Dependencies

struct CustomObservationView: View {
    @Environment(\.dependencyContext) private var context
    
    @DependencyState private var model: CustomModel
    
    init() {
        _model = DependencyState { dependencies in
            CustomModel(user: "Test", dependencies: dependencies)
        }
    }
    
    var body: some View {
        List {
            LabeledContent("Context", value: context.description)
            LabeledContent("API version", value: model.version)
            
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
        CustomObservationView()
    }
}
