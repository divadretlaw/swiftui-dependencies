//
//  DependencyKey.swift
//  swiftui-dependencies
//
//  Created by David Walter on 23.09.23.
//

import Foundation
import SwiftUI

/// A key for accessing values in the dependencies.
///
/// You can create custom dependency values by extending the
/// ``DependencyValues`` structure with new properties.
/// First declare a new dependency key type and specify a value for the
/// required values:
///
/// ```swift
/// private struct MyDependencyKey: DependencyKey {
///     static let defaultValue: String = "Default value"
///     static let previewValue: String = "Preview value"
///     static let testingValue: String = "Testing value"
/// }
/// ```
/// The Swift compiler automatically infers the associated ``Value`` type as the
/// type you specify for the default value. Then use the key to define a new
/// dependency value property:
///
/// ```swift
/// extension DependencyValues {
///     var myCustomValue: String {
///         get { self[MyDependencyKey.self] }
///         set { self[MyDependencyKey.self] = newValue }
///     }
/// }
/// ```
///
/// Clients of your dependency value never use the key directly.
/// Instead, they use the key path of your custom dependency value property.
/// To set the dependency value for a view and all its subviews, add the
/// ``View/dependency(_:_:)`` view modifier to that view:
///
/// ```swift
/// MyView()
///     .dependency(\.myCustomValue, "Another string")
/// ```
///
/// This will only ever affect the default value. Preview and testing values will always
/// stay constant.
public protocol DependencyKey {
    /// The associated type representing the type of the dependency key's value.
    associatedtype Value = Self

    /// The default value for the dependecy key in the ``DependencyContext/default`` context
    static var defaultValue: Value { get }
    /// The default  value for the dependecy key in the ``DependencyContext/preview`` context
    static var previewValue: Value { get }
    /// The  default value for the dependecy key in the ``DependencyContext/testing`` context
    static var testingValue: Value { get }
}

// MARK: - Default implementations

extension DependencyKey {
    /// Default implementation: Will use ``DependencyKey/testingValue``
    public static var previewValue: Value { testingValue }
    /// Default implementation: Will use ``DependencyKey/defaultValue``
    public static var testingValue: Value { defaultValue }
}
