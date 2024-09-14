import Foundation
import Dependencies

@Observable
@MainActor final class CustomModel: ObservableDependency {
    var loggedInUser: String?
    private let api: API
    
    init(value: String, dependencies: DependencyValues) {
        self.loggedInUser = value
        self.api = dependencies.api
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
