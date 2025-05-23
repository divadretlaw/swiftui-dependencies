import SwiftUI
import Dependencies

struct ObserveableObjectView: View {
    @Environment(\.dependencyContext) private var context
    
    @DependencyObject private var viewModel: ViewModel
    
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
        .navigationTitle("ObservableObject")
        .animation(.default, value: viewModel.loggedInUser)
        .modifier(DemoViewModifier())
    }
}

#Preview {
    NavigationStack {
        ObserveableObjectView()
    }
}
