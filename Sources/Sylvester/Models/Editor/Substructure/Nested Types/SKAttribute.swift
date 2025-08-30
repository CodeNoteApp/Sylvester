//
//  SKAttribute.swift
//  Sylvester 😼
//
//  Created by Chris Zielinski on 12/5/18.
//  Copyright © 2018 Big Z Labs. All rights reserved.
//

import MetaCodable
import SylvesterEnumerations

open class SKAttribute: SKGenericKindEntity<SKAttribute.Kind> {

    // MARK: - Internal Declarations

    enum CodingKeys: String, CodingKey {
        case attribute = "key.attribute"
    }

    // MARK: - Public Type Aliases

    public typealias Kind = SKAttributeKind

    open override class var kindCodingKey: SKKey { .attribute }
}

// MARK: - SKSortedEntities<SKAttribute> Methods

extension SKSortedEntities where Entity: SKAttribute {
    /// Returns the attribute with the specified kind, or `nil` if nonexistent.
    ///
    /// - Parameter kind: The kind of the attribute to return.
    /// - Returns: The `SKAttribute`, or `nil` if nonexistent.
    public func attribute(with kind: SKAttribute.Kind) -> SKAttribute? {
        return entities.first(where: { $0.kind == kind })
    }

    /// Returns whether the specified attribute kind is a member of the entities.
    ///
    /// - Parameter kind: The kind of the attribute.
    /// - Returns: `true` if the attribute kind is a member of the entities; otherwise, `false`.
    public func containsAttribute(with kind: SKAttribute.Kind) -> Bool {
        return attribute(with: kind) != nil
    }
}
