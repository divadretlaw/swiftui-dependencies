import SwiftUI
import Dependencies

struct ContentView: View {
    @Environment(\.self) private var environment
    @Environment(\.dependencyContext) private var context
    
    @DependencyObject private var viewModel: ViewModel
    @DependencyObject private var customViewModel: CustomViewModel
    @DependencyState private var model: Model
    
    @State private var loggedInUser: String?
    @Dependency(\.api) private var api: API
    
    init() {
        _customViewModel = DependencyObject { dependencies in
            return CustomViewModel(value: "Test", dependencies: dependencies)
        }
    }
    
    var body: some View {
        NavigationStack {
            List {
                LabeledContent("Context", value: context.description)
                
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
                } header: {
                    Text("ObservableObject")
                        .headerProminence(.increased)
                }
                
                Section {
                    if let user = customViewModel.loggedInUser {
                        LabeledContent("User", value: user)
                        Button("Logout", role: .destructive) {
                            customViewModel.logout()
                        }
                    } else {
                        TaskButton("Login") {
                            await customViewModel.login()
                        }
                    }
                } header: {
                    Text("ObservableObject (custom init)")
                        .headerProminence(.increased)
                }
                
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
                } header: {
                    Text("Observation")
                        .headerProminence(.increased)
                }
                
                Section {
                    if let user = loggedInUser {
                        LabeledContent("User", value: user)
                        Button("Logout", role: .destructive) {
                            logout()
                        }
                    } else {
                        TaskButton("Login") {
                            await login()
                        }
                    }
                } header: {
                    Text("View")
                        .headerProminence(.increased)
                }
            }
            .navigationTitle("Demo")
            .animation(.default, value: viewModel.loggedInUser)
            .animation(.default, value: customViewModel.loggedInUser)
            .animation(.default, value: model.loggedInUser)
            .animation(.default, value: loggedInUser)
        }
    }
    
    func login() async {
        do {
            self.loggedInUser = try await api.login()
        } catch {
            print(error.localizedDescription)
            self.loggedInUser = nil
        }
    }
    
    func logout() {
        self.loggedInUser = nil
    }
}

#Preview("Content View") {
    ContentView()
}

#Preview("Content View with overriden API") {
    ContentView()
        .dependency(\.api, AppAPI(session: .shared))
}
