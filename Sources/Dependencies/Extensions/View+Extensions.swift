//
//  View+Extensions.swift
//  swiftui-dependencies
//
//  Created by David Walter on 30.09.23.
//

import SwiftUI

public extension View {
    /// Sets the dependency value of the specified key path to the given value.
    ///
    /// Use this modifier to set one of the writable properties of the
    /// ``DependencyValues`` structure, including custom values that you
    /// create.
    ///
    /// This modifier affects the given view,
    /// as well as that view's descendant views. It has no effect
    /// outside the view hierarchy on which you call it.
    ///
    /// - Parameters:
    ///   - keyPath: A key path that indicates the property of the
    ///     ``DependencyValues`` structure to update.
    ///   - value: The new value to set for the item specified by `keyPath`.
    ///
    /// - Returns: A view that has the given value set in its dependencies.
    func dependency<V>(
        _ keyPath: WritableKeyPath<DependencyValues, V>,
        _ value: V
    ) -> some View {
        transformEnvironment(\.dependencies) { dependencies in
            dependencies[keyPath: keyPath] = value
        }
    }
}
