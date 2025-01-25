//
//  DemoTests.swift
//  DemoTests
//
//  Created by David Walter on 25.01.25.
//

import Testing
@testable import Demo
import Dependencies
import SnapshotTesting

/// Unit Tests, like when using [SnapshotTesting](https://github.com/pointfreeco/swift-snapshot-testing),
/// will automatically use the test implementation of any `Depdendency`
///
/// You can always still override the default implementation
@MainActor struct DemoTests {
    @Test func viewObserveableObjectView() async throws {
        let defaultView = ObserveableObjectView()
        let overridenView = ObserveableObjectView().dependency(\.api, PreviewAPI())
        // Default
        assertSnapshot(of: defaultView, as: .image)
        // Overriden dependency
        assertSnapshot(of: overridenView, as: .image)
    }
    
    @Test func viewCustomObserveableObjectView() async throws {
        let view = CustomObserveableObjectView()
        assertSnapshot(of: view, as: .image)
    }
    
    @Test func viewObservationView() async throws {
        let view = ObservationView()
        assertSnapshot(of: view, as: .image)
    }
    
    @Test func viewCustomObservationView() async throws {
        let view = CustomObservationView()
        assertSnapshot(of: view, as: .image)
    }
    
    @Test func viewSwiftUI() async throws {
        let view = SwiftUIView()
        assertSnapshot(of: view, as: .image)
    }
}
