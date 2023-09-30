//
//  DependencyKey.swift
//  swiftui-dependencies
//
//  Created by David Walter on 29.09.23.
//

import Foundation
import SwiftUI

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, visionOS 1.0, *)
/// A property wrapper type that subscribes to an observable depenency object and
/// invalidates a view whenever the observable dependency object changes.
@propertyWrapper
public struct DependencyState<Value>: DynamicProperty where Value: ObservableDependency {
    @Environment(\.dependencies) private var dependencies
    
    @State private var coordinator = Coordinator()
    
    /// Creates an observed object without an initial value.
    ///
    /// Don't call this initializer directly. Instead, declare
    /// an input to a view with the `@DependencyObject` attribute.
    public init() {
        // Create initially empty object
    }
    
    @Observable
    class Coordinator {
        private(set) var wrappedValue: Value?
        
        func update(build: () -> Value) {
            guard wrappedValue == nil else { return }
            self.wrappedValue = build()
        }
    }
    
    // MARK: - @propertyWrapper
    
    /// The underlying value referenced by the dependency object.
    @MainActor public var wrappedValue: Value {
        coordinator.wrappedValue ?? Value(dependencies: dependencies)
    }
    
    /// A projection of the dependency object that creates bindings to its properties.
    @MainActor public var projectedValue: Wrapper {
        Wrapper(value: wrappedValue)
    }
    
    /// A wrapper of the underlying observable object that can create bindings to its properties.
    @dynamicMemberLookup public struct Wrapper {
        private let value: Value
        
        init(value: Value) {
            self.value = value
        }
        
        /// Gets a binding to the value of a specified key path.
        ///
        /// - Parameter keyPath: A key path to a specific  value.
        ///
        /// - Returns: A new binding.
        public subscript<Subject>(dynamicMember keyPath: ReferenceWritableKeyPath<Value, Subject>) -> Binding<Subject> {
            Binding {
                value[keyPath: keyPath]
            } set: {
                value[keyPath: keyPath] = $0
            }
        }
    }
    
    // MARK: - DynamicProperty
    
    public func update() {
        coordinator.update {
            Value(dependencies: dependencies)
        }
    }
}
