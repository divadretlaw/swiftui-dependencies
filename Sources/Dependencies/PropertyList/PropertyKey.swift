//
//  PropertyKey.swift
//  swiftui-dependencies
//
//  Created by David Walter on 01.10.23.
//

import Foundation

struct PropertyKey: Identifiable, Hashable, Equatable, Sendable, CustomStringConvertible {
    let keyType: Any.Type
    
    init<K>(keyType: K.Type) where K: DependencyKey {
        self.keyType = keyType
    }
    
    // MARK: - Identifiable
    
    var id: ObjectIdentifier {
        ObjectIdentifier(keyType)
    }
    
    // MARK: - Hashable
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    // MARK: - Equatable
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
    
    // MARK: - CustomStringConvertible
    
    var description: String {
        "\(keyType)"
    }
}
