import Foundation
import OSLog
import Dependencies

@MainActor final class CustomViewModel: ObservableDependencyObject {
    @Published private(set) var loggedInUser: String?
    
    private let api: API
    
    init(user: String, dependencies: DependencyValues) {
        Logger.demo.debug("CustomViewModel.\(#function)")
        
        self.loggedInUser = user
        self.api = dependencies.api
    }
    
    deinit {
        Logger.demo.debug("CustomViewModel.\(#function)")
    }
    
    var version: String {
        api.version
    }
    
    func login() async {
        Logger.demo.track()
        
        do {
            self.loggedInUser = try await api.login()
        } catch {
            Logger.demo.error("\(error.localizedDescription)")
            self.loggedInUser = nil
        }
    }
    
    func logout() {
        Logger.demo.track()
        
        self.loggedInUser = nil
    }
}
