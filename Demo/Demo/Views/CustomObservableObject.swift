//
//  CustomObserveableObjectView.swift
//  Demo
//
//  Created by David Walter on 06.10.23.
//

import SwiftUI
import Dependencies

struct CustomObserveableObjectView: View {
    @Environment(\.dependencyContext) private var context
    
    @DependencyObject private var viewModel: CustomViewModel
    
    init() {
        _viewModel = DependencyObject { dependencies in
            CustomViewModel(value: "Test", dependencies: dependencies)
        }
    }
    
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
        .navigationTitle("ObservableObject (custom init)")
        .animation(.default, value: viewModel.loggedInUser)
    }
}

#Preview {
    NavigationStack {
        CustomObserveableObjectView()
    }
}
