//
//  PropertyList.swift
//  swiftui-dependencies
//
//  Created by David Walter on 01.10.23.
//

import Foundation

struct PropertyList: ExpressibleByDictionaryLiteral, CustomStringConvertible {
    private var elements: [PropertyKey: Any]
    
    init() {
        self.elements = [:]
    }
    
    init(dictionaryLiteral elements: (PropertyKey, Any)...) {
        var dictionary: [PropertyKey: Any] = [:]
        for (key, value) in elements {
            dictionary[key] = value
        }
        self.elements = dictionary
    }
    
    subscript<K>(keyType: K.Type) -> K.Value? where K: DependencyKey {
        get {
            let key = PropertyKey(keyType: keyType)
            return elements[key] as? K.Value
        }
        set {
            let key = PropertyKey(keyType: keyType)
            elements[key] = newValue
        }
    }
    
    var isEmpty: Bool {
        elements.isEmpty
    }
    
    // MARK: - CustomStringConvertible
    
    var description: String {
        let description = elements
            .map { key, value in
                "\(key) = \(value)"
            }
            .joined(separator: ", ")
        return "[\(description)]"
    }
}
