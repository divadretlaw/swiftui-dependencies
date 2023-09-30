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
