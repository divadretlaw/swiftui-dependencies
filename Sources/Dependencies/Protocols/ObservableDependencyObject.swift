//
//  ObservableDependencyObject.swift
//  swiftui-dependencies
//
//  Created by David Walter on 23.09.23.
//

import Foundation

/// A type of object with a publisher that emits before the object has changed and uses dependency injection.
public protocol ObservableDependencyObject: ObservableObject, DependencyInjectable {
}

// MARK: - Default implementations

public extension ObservableDependencyObject {
    // swiftlint:disable:next missing_docs
    init(dependencies: DependencyValues) {
        fatalError("""
        '\(#function)' has not been implemented for this 'ObservableDependencyObject'.
        
        If this was intentional, please initialize the 'ObservableDependencyObject' like this:
        _viewModel = DependencyObject { dependencies in
            // ViewModel.init
        }
        """)
    }
}
