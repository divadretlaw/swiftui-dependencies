import SwiftUI
import Dependencies

@MainActor
struct SwiftUIView: View {
    @Environment(\.dependencyContext) private var context
    
    @State private var loggedInUser: String?
    @Dependency(\.api) private var api: API
    
    var body: some View {
        List {
            LabeledContent("Context", value: context.description)
            
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

#Preview {
    NavigationStack {
        SwiftUIView()
    }
}
