import SylvesterEnumerations

open class SKGenericKindEntity<Kind: Equatable & Codable>: SKByteRange {
    // MARK: - Public Stored Properties

    /// The kind of the entity.
    public let kind: Kind

    // MARK: - Public Initializers

    public init(kind: Kind, offset: Int, length: Int) {
        self.kind = kind

        super.init(offset: offset, length: length)
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.kind = try container.decode(Kind.self, forKey: .init(stringValue: Self.kindCodingKey.rawValue))
        try super.init(from: decoder)
    }

    public override func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(kind, forKey: .init(stringValue: Self.kindCodingKey.rawValue))
        try super.encode(to: encoder)
    }

    // MARK: - Equatable Protocol

    open override func isEqual(to rhs: SKByteRange) -> Bool {
        let isSuperEqual = super.isEqual(to: rhs)

        guard let entity = rhs as? SKGenericKindEntity<Kind> else {
            return false
        }

        return isSuperEqual && kind == entity.kind
    }

    open class var kindCodingKey: SKKey {
        .kind
    }

    private struct CodingKeys: CodingKey {
        var stringValue: String

        init(stringValue: String) {
            self.stringValue = stringValue
        }

        var intValue: Int?

        init?(intValue: Int) {
            self.intValue = intValue
            self.stringValue = "\(intValue)"
        }
    }
}
