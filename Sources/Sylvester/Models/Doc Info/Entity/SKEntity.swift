/// Represents the default entity returned by _SourceKit_ doc info requests.
public final class SKEntity: SKBaseEntity, SKFinalSubclass {
    public override func decodeChildren(from container: DecodingContainer) throws -> [SKBaseEntity]? {
        return try decodeChildren(SKEntity.self, from: container)
    }
}
