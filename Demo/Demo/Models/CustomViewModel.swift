import Foundation
import Dependencies

final class CustomViewModel: ObservableDependencyObject {
    @Published var loggedInUser: String?
    
    private let api: API
    
    init(value: String, dependencies: DependencyValues) {
        self.loggedInUser = "Test"
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
