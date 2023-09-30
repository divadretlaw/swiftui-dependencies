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
                        Text(user)
                        Button("Logout") {
                            viewModel.logout()
                        }
                    } else {
                        Button("Login") {
                            Task {
                                await viewModel.login()
                            }
                        }
                    }
                } header: {
                    Text("Regular")
                }
                
                Section {
                    if let user = customViewModel.loggedInUser {
                        Text(user)
                        Button("Logout") {
                            customViewModel.logout()
                        }
                    } else {
                        Button("Login") {
                            Task {
                                await customViewModel.login()
                            }
                        }
                    }
                } header: {
                    Text("Custom")
                }
                
                Section {
                    if let user = model.loggedInUser {
                        Text(user)
                        Button("Logout") {
                            model.logout()
                        }
                    } else {
                        Button("Login") {
                            Task {
                                await model.login()
                            }
                        }
                    }
                } header: {
                    Text("Observation")
                }
                
                Section {
                    if let user = loggedInUser {
                        Text(user)
                        Button("Logout") {
                            logout()
                        }
                    } else {
                        Button("Login") {
                            Task {
                                await login()
                            }
                        }
                    }
                } header: {
                    Text("SwiftUI")
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
