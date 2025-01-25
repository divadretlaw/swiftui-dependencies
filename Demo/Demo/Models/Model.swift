import Foundation
import OSLog
import Observation
import Dependencies

@MainActor @Observable final class Model: ObservableDependency {
    private(set) var loggedInUser: String?
    
    private let api: API
    
    required init(dependencies: DependencyValues) {
        Logger.demo.debug("Model.\(#function)")
        
        self.api = dependencies.api
    }
    
    deinit {
        Logger.demo.debug("Model.\(#function)")
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
