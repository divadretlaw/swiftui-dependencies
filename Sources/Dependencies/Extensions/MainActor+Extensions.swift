//
//  MainActor.swift
//  swiftui-dependencies
//
//  Created by David Walter on 14.07.24.
//

import Foundation

extension MainActor {
    /// Execute the given body closure on the main actor without enforcing MainActor isolation.
    ///
    /// The method will be dispatched in sync to the main-thread if its on a non-main thread.
    @_unavailableFromAsync
    static func runSync<T>(_ body: @MainActor () throws -> T) rethrows -> T where T: Sendable {
        if Thread.isMainThread {
            return try MainActor.assumeIsolated(body)
        } else {
            return try DispatchQueue.main.sync {
                return try MainActor.assumeIsolated(body)
            }
        }
    }
}