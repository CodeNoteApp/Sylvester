import SylvesterEnumerations

open class SKElement: SKGenericKindEntity<SKElementKind> {
    // MARK: - Public Type Aliases

    public typealias Kind = SKElementKind

    open override class var kindCodingKey: SKKey { .kind }
}

// MARK: - SKSortedEntities<SKElement> Methods

extension SKSortedEntities where Entity: SKElement {
    /// Returns the element with the specified kind, or `nil` if nonexistent.
    ///
    /// - Parameter kind: The kind of the element to return.
    /// - Returns: The `SKElement`, or `nil` if nonexistent.
    public func element(with kind: SKElement.Kind) -> SKElement? {
        return entities.first(where: { $0.kind == kind })
    }

    /// Returns whether the specified element kind is a member of the entities.
    ///
    /// - Parameter kind: The kind of the element.
    /// - Returns: `true` if the element kind is a member of the entities; otherwise, `false`.
    public func containsElement(with kind: SKElement.Kind) -> Bool {
        return element(with: kind) != nil
    }
}
