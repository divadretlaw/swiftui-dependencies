//
//  DependencyContext.swift
//  swiftui-dependencies
//
//  Created by David Walter on 23.09.23.
//

import Foundation
import SwiftUI

/// The context of the dependencies
public enum DependencyContext: Identifiable, Hashable, Equatable, Sendable, CustomStringConvertible {
    /// The default context for dependencies.
    ///
    /// This context is automatically used when no other context was determined.
    /// Dependencies accessed from this context will use ``DependencyKey/defaultValue`` as the default value.
    case `default`
    /// The preview context for dependencies.
    ///
    /// This context is automatically used when running in a SwiftUI Preview.
    /// Dependencies accessed from this context will use ``DependencyKey/previewValue`` as the default value.
    case preview
    /// The context for the dependencies is testing.
    ///
    /// This context is automatically used when running in a XCTest.
    /// Dependencies accessed from this context will use ``DependencyKey/testingValue`` as the default value.
    case testing

    /// Returns the current ``DependencyContext``
    static var current: DependencyContext {
        if ProcessInfo.processInfo.isPreview {
            return .preview
        } else if ProcessInfo.processInfo.isTesting {
            return .testing
        } else {
            return .default
        }
    }

    // MARK: Identifiable

    public var id: String {
        switch self {
        case .default:
            return "default"
        case .preview:
            return "preview"
        case .testing:
            return "testing"
        }
    }

    // MARK: CustomStringConvertible

    public var description: String {
        switch self {
        case .default:
            return "Default"
        case .preview:
            return "Preview"
        case .testing:
            return "Testing"
        }
    }
}

extension ProcessInfo {
    var isPreview: Bool {
        environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    }

    var isTesting: Bool {
        // Testing via Xcode

        if environment.keys.contains("XCTestBundlePath") {
            return true
        }
        if environment.keys.contains("XCTestConfigurationFilePath") {
            return true
        }
        if environment.keys.contains("XCTestSessionIdentifier") {
            return true
        }

        // Testing via swift CLI
        if arguments.contains(where: { argument in
            let url = URL(fileURLWithPath: argument)
            return url.lastPathComponent == "xctest" || url.pathExtension == "xctest"
        }) {
            return true
        }

        if arguments.contains("--testing-library"), arguments.contains("swift-testing") {
            return true
        }

        return false
    }
}

// MARK: - Environment

private struct DependencyContextKey: EnvironmentKey {
    static var defaultValue: DependencyContext { .current }
}

extension EnvironmentValues {
    /// The current ``DependencyContext`` of the dependencies
    public var dependencyContext: DependencyContext {
        self[DependencyContextKey.self]
    }
}
