import SwiftUI
import Dependencies

struct CustomObserveableObjectView: View {
    @Environment(\.dependencyContext) private var context
    
    @DependencyObject private var viewModel: CustomViewModel
    
    init() {
        _viewModel = DependencyObject { dependencies in
            CustomViewModel(user: "Test", dependencies: dependencies)
        }
    }
    
    var body: some View {
        List {
            LabeledContent("Context", value: context.description)
            LabeledContent("API version", value: viewModel.version)
            
            Section {
                if let user = viewModel.loggedInUser {
                    LabeledContent("User", value: user)
                    Button("Logout", role: .destructive) {
                        viewModel.logout()
                    }
                } else {
                    TaskButton("Login") {
                        await viewModel.login()
                    }
                }
            }
        }
        .navigationTitle("ObservableObject (custom init)")
        .animation(.default, value: viewModel.loggedInUser)
        .modifier(DemoViewModifier())
    }
}

#Preview {
    NavigationStack {
        CustomObserveableObjectView()
    }
}
