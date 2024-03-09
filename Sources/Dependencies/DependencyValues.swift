//
//  DependencyValues.swift
//  swiftui-dependencies
//
//  Created by David Walter on 23.09.23.
//

import Foundation

/// A collection of dependency values propagated through a view hierarchy.
public struct DependencyValues: CustomStringConvertible {
    private var defaultValues: PropertyList
    private var previewValues: PropertyList
    private var testingValues: PropertyList
    
    /// Creates a dependency values instance.
    ///
    /// You don't typically create an instance of ``DependencyValues``
    /// directly. Doing so would provide access only to default values that
    /// don't update based on system settings or device characteristics.
    /// Instead, you rely on an dependency values' instance
    /// that SwiftUI manages for you when you use the ``Dependency``
    /// property wrapper and the ``View/dependency(_:_:)`` view modifier.
    public init() {
        self.defaultValues = [:]
        self.previewValues = [:]
        self.testingValues = [:]
    }
    
    /// Accesses the dependency value associated with a custom key.
    ///
    /// Create custom dependency values by defining a key
    /// that conforms to the ``DependencyKey`` protocol, and then using that
    /// key with the subscript operator of the ``DependencyValues`` structure
    /// to get and set a value for that key:
    ///
    /// ```swift
    /// private struct MyDependencyKey: DependencyKey {
    ///     static let defaultValue: String = "Default value"
    /// }
    ///
    /// extension DependencyValues {
    ///     var myCustomValue: String {
    ///         get { self[MyDependencyKey.self] }
    ///         set { self[MyDependencyKey.self] = newValue }
    ///     }
    /// }
    /// ```
    ///
    /// You use custom dependency values the same way you use system-provided
    /// values, setting a value with the ``View/dependency(_:_:)`` view
    /// modifier, and reading values with the ``Dependency`` property wrapper.
    /// You can also provide a dedicated view modifier as a convenience for
    /// setting the value:
    ///
    /// ```swift
    /// extension View {
    ///     func myCustomValue(_ myCustomValue: String) -> some View {
    ///         dependency(\.myCustomValue, myCustomValue)
    ///     }
    /// }
    /// ```
    public subscript<K>(key: K.Type) -> K.Value where K: DependencyKey {
        get { self[key, for: DependencyContext.current] }
        set { self[key, for: DependencyContext.current] = newValue }
    }
    
    private subscript<K>(key: K.Type, for context: DependencyContext) -> K.Value where K: DependencyKey {
        get {
            switch context {
            case .preview:
                return previewValues[key] ?? key.previewValue
            case .testing:
                return testingValues[key] ?? key.testingValue
            default:
                return defaultValues[key] ?? key.defaultValue
            }
        }
        set {
            switch context {
            case .preview:
                previewValues[key] = newValue
            case .testing:
                testingValues[key] = newValue
            default:
                defaultValues[key] = newValue
            }
        }
    }
    
    /// A string that represents the contents of the dependecy values instance.
    public var description: String {
        """
        default: \(defaultValues.description)
        preview: \(previewValues.description)
        testing: \(testingValues.description)
        """
    }
}
