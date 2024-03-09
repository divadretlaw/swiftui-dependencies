//
//  ObservableDependency.swift
//  swiftui-dependencies
//
//  Created by David Walter on 23.09.23.
//

import Foundation

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, visionOS 1.0, *)
/// A `Observable` annotated model that uses dependency injection.
public protocol ObservableDependency: AnyObject, DependencyInjectable {
}

// MARK: - Default implementations

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, visionOS 1.0, *)
public extension ObservableDependency {
    // swiftlint:disable:next missing_docs
    init(dependencies: DependencyValues) {
        let name = String(describing: Self.self)
        let message = """
        '\(#function)' has not been implemented for '\(name)'.
        
        If this was intentional, please initialize your model like this:
        _model = DependencyState { dependencies in
            \(name).init
        }
        """
        fatalError(message)
    }
}
