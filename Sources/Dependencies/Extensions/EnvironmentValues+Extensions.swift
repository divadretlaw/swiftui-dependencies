//
//  EnvironmentValues+Extensions.swift
//  swiftui-dependencies
//
//  Created by David Walter on 30.09.23.
//

import SwiftUI

private struct DependencyValuesKey: EnvironmentKey {
    static var defaultValue: DependencyValues {
        DependencyValues()
    }
}

extension EnvironmentValues {
    /// The dependecy values.
    var dependencies: DependencyValues {
        get { self[DependencyValuesKey.self] }
        set { self[DependencyValuesKey.self] = newValue }
    }
}
