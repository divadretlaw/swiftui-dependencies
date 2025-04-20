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

extension ObservableDependencyObject {
    // swiftlint:disable:next missing_docs
    public init(dependencies: DependencyValues) {
        let name = String(describing: Self.self)
        let message = """
            '\(#function)' has not been implemented for '\(name)'.

            If this was intentional, please initialize your view model like this:
            _viewModel = DependencyObject { dependencies in
                \(name).init
            }
            """
        fatalError(message)
    }
}
