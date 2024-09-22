import Foundation
import Dependencies

protocol API: Sendable {
    var version: String { get }
    func login() async throws -> String
}

struct AppAPI: API {
    let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    var version: String { "default" }
    
    func login() async throws -> String {
        let (data, _) = try await session.data(from: URL(string: "https://eu.httpbin.org/get?name=User")!)
        let result = try JSONDecoder().decode(LoginResponse.self, from: data)
        return result.args.name
    }
}

struct PreviewAPI: API {
    var version: String { "preview" }
    
    func login() async throws -> String {
        try await Task.sleep(nanoseconds: 1 * NSEC_PER_SEC)
        return "Preview-User"
    }
}

struct TestAPI: API {
    var version: String { "test" }
    
    func login() async throws -> String {
        return "Test-User"
    }
}

struct DemoAPI: API {
    var version: String { "demo" }
    
    func login() async throws -> String {
        return "Demo-User"
    }
}

private struct ApiKey: DependencyKey {
    static var defaultValue: API {
        AppAPI(session: .shared)
    }

    static var previewValue: API {
        PreviewAPI()
    }
    
    static var testingValue: API {
        TestAPI()
    }
}

extension DependencyValues {
    var api: API {
        get { self[ApiKey.self] }
        set { self[ApiKey.self] = newValue }
    }
}
