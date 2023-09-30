//
//  Dependency.swift
//  swiftui-dependencies
//
//  Created by David Walter on 29.09.23.
//

import Foundation
import SwiftUI

/// A property wrapper that reads a value from a view's dependencies.
///
/// Use the ``Dependency`` property wrapper to read a value
/// stored in a view's dependencies. Indicate the value to read using an
/// ``DependencyValues`` key path in the property declaration.
@propertyWrapper public struct Dependency<Value>: DynamicProperty {
    @Environment(\.dependencies) private var dependencies
    
    private let keyPath: KeyPath<DependencyValues, Value>
    
    /// Creates an depdendency property to read the specified key path.
    ///
    /// Don’t call this initializer directly. Instead, declare a property
    /// with the ``Dependency`` property wrapper, and provide the key path of
    /// the dependency value that the property should reflect:
    ///
    /// ```swift
    /// struct MyView: View {
    ///     @Dependency(\.date) var date: Date
    ///
    ///     // ...
    /// }
    /// ```
    /// 
    /// SwiftUI automatically updates any parts of `MyView` that depend on
    /// the property when the associated dependency value changes.
    /// You can't modify the dependency value using a property like this.
    /// Instead, use the ``View/dependency(_:_:)`` view modifier on a view to
    /// set a value for a view hierarchy.
    ///
    /// - Parameter keyPath: A key path to a specific resulting value.
    public init(_ keyPath: KeyPath<DependencyValues, Value>) {
        self.keyPath = keyPath
    }
    
    /// The current value of the dependency property.
    ///
    /// The wrapped value property provides primary access to the value's data.
    /// However, you don't access `wrappedValue` directly. Instead, you read the
    /// property variable created with the ``Dependency`` property wrapper:
    ///
    ///     @Dependency(\.date) var date: Date
    ///
    ///     var body: some View {
    ///         Text(date)
    ///     }
    ///
    public var wrappedValue: Value {
        dependencies[keyPath: keyPath]
    }
}
