//
//  DependencyInjectable.swift
//  swiftui-dependencies
//
//  Created by David Walter on 30.09.23.
//

import Foundation

/// A type that can be initialized by the given ``DependencyValues``
public protocol DependencyInjectable {
    /// Initialize the object using the given ``DependencyValues``
    ///
    /// - Parameter dependencies: The registered dependencies
    ///
    /// The provided dependencies depend on the current ``DependencyContext``
    @MainActor init(dependencies: DependencyValues)
}
