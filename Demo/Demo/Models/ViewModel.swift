import Foundation
import OSLog
import Dependencies

@MainActor final class ViewModel: ObservableDependencyObject {
    @Published private(set) var loggedInUser: String?
    
    private let api: API
    
    required init(dependencies: DependencyValues) {
        Logger.demo.debug("ViewModel.\(#function)")
        
        self.api = dependencies.api
    }
    
    deinit {
        Logger.demo.debug("ViewModel.\(#function)")
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
