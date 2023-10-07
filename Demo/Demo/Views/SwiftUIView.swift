//
//  SwiftUIView.swift
//  Demo
//
//  Created by David Walter on 06.10.23.
//

import SwiftUI
import Dependencies

struct SwiftUIView: View {
    @State private var loggedInUser: String?
    @Dependency(\.api) private var api: API
    
    var body: some View {
        List {
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
