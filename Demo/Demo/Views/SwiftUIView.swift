import SwiftUI
import OSLog
import Dependencies

@MainActor struct SwiftUIView: View {
    @Environment(\.dependencyContext) private var context
    
    @State private var loggedInUser: String?
    @Dependency(\.api) private var api: API
    
    var body: some View {
        List {
            LabeledContent("Context", value: context.description)
            LabeledContent("API version", value: api.version)
            
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
            }
        }
        .navigationTitle("SwiftUI")
        .animation(.default, value: loggedInUser)
        .modifier(DemoViewModifier())
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

#Preview {
    NavigationStack {
        SwiftUIView()
    }
}
