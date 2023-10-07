//
//  ObserveableObjectView.swift
//  Demo
//
//  Created by David Walter on 06.10.23.
//

import SwiftUI
import Dependencies

struct ObserveableObjectView: View {
    @Environment(\.dependencyContext) private var context
    
    @DependencyObject private var viewModel: ViewModel
    
    var body: some View {
        List {
            LabeledContent("Context", value: context.description)
            
            Section {
                if let user = viewModel.loggedInUser {
                    LabeledContent("User", value: user)
                    Button("Logout", role: .destructive) {
                        viewModel.logout()
                    }
                } else {
                    TaskButton("Login") {
                        await viewModel.login()
                    }
                }
            }
        }
        .navigationTitle("ObservableObject")
        .animation(.default, value: viewModel.loggedInUser)
    }
}

#Preview {
    NavigationStack {
        ObserveableObjectView()
    }
}
