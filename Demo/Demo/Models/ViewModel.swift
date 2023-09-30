import Foundation
import Dependencies

class ViewModel: ObservableDependencyObject {
    @Published var loggedInUser: String?
    
    private let api: API
    
    required init(dependencies: DependencyValues) {
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
