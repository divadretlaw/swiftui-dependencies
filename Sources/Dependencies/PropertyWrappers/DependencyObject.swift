//
//  DependencyKey.swift
//  swiftui-dependencies
//
//  Created by David Walter on 29.09.23.
//

import Foundation
import SwiftUI
import Combine

/// A property wrapper type that subscribes to an observable depenency object and
/// invalidates a view whenever the observable dependency object changes.
@MainActor
@propertyWrapper
public struct DependencyObject<ObjectType>: DynamicProperty where ObjectType: ObservableDependencyObject {
    @Environment(\.dependencies) private var dependencies
    
    @StateObject private var coordinator = Coordinator()
    private let build: ((_ dependencies: DependencyValues) -> ObjectType)?
    
    /// Creates an observed object without an initial value.
    ///
    /// Don't call this initializer directly. Instead, declare
    /// an input to a view with the `@DependencyObject` attribute.
    public init() {
        self.build = nil
    }
    
    /// Creates a new ``DependencyObject`` with a closure that initializes an observed object from dependency values.
    /// 
    /// - Parameter build: Callback that initializes the observed object
    public init(_ build: @escaping (_ dependencies: DependencyValues) -> ObjectType) {
        self.build = build
    }
    
    @MainActor private class Coordinator: ObservableObject {
        var wrappedValue: ObjectType?
        private var cancellable: AnyCancellable?
        
        func update(build: () -> ObjectType) {
            guard wrappedValue == nil else { return }
            
            // Disable changes during update
            var isUpdating = true
            defer { isUpdating = false }
            
            let value = build()
            self.wrappedValue = value
            
            self.cancellable = value.objectWillChange
                .receive(on: DispatchQueue.main)
                .sink { [weak self] _ in
                    guard let self, !isUpdating else { return }
                    self.objectWillChange.send()
                }
        }
    }
    
    // MARK: - @propertyWrapper
    
    /// The underlying value referenced by the dependency object.
    public var wrappedValue: ObjectType {
        coordinator.wrappedValue ?? ObjectType(dependencies: dependencies)
    }
    
    /// A projection of the dependency object that creates bindings to its properties.
    public var projectedValue: Wrapper {
        Wrapper(value: wrappedValue)
    }
    
    /// A wrapper of the underlying observable object that can create bindings to its properties.
    @MainActor @dynamicMemberLookup public struct Wrapper: Sendable {
        private let value: ObjectType
        
        init(value: ObjectType) {
            self.value = value
        }
        
        /// Gets a binding to the value of a specified key path.
        ///
        /// - Parameter keyPath: A key path to a specific  value.
        ///
        /// - Returns: A new binding.
        public subscript<Subject>(
            dynamicMember keyPath: ReferenceWritableKeyPath<ObjectType, Subject>
        ) -> Binding<Subject> {
            Binding {
                value[keyPath: keyPath]
            } set: {
                value[keyPath: keyPath] = $0
            }
        }
    }
    
    // MARK: - DynamicProperty
    
    public nonisolated func update() {
        MainActor.runSync {
            if let build = self.build {
                coordinator.update {
                    build(dependencies)
                }
            } else {
                coordinator.update {
                    ObjectType(dependencies: dependencies)
                }
            }
        }
    }
}
