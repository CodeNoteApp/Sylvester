import Foundation
import SylvesterEnumerations

/// Represents a structure of symbols (a class has its methods as sub-entities, etc.).
///
/// This includes the function parameters and their types as entities. Each entity refers to the range of the
/// original text via `offset + length` entries.
open class SKBaseEntity: SKSequence {
    // MARK: - Internal Declarations

    public enum CodingKeys: String, CodingKey {
        case kind = "key.kind"
        case name = "key.name"
        case keyword = "key.keyword"
        case usr = "key.usr"
        case offset = "key.offset"
        case length = "key.length"
        case fullyAnnotatedDeclaration = "key.fully_annotated_decl"
        case docFullAsXML = "key.doc.full_as_xml"
        case inherits = "key.inherits"
        case genericRequirements = "key.generic_requirements"
        case genericParameters = "key.generic_params"
        case internalChildren = "key.entities"
    }

    // MARK: - Public Type Aliases

    public typealias Kind = SKDeclarationKind
    public typealias Inherit = SKInherit
    public typealias GenericRequirement = SKGenericRequirement
    public typealias GenericParameter = SKGenericParameter
    public typealias DecodingContainer = KeyedDecodingContainer<CodingKeys>

    // MARK: - Public Stored Properties

    /// The UID for the declaration or reference kind (function, class, etc.).
    public let kind: Kind
    /// The displayed name for the entity.
    public let name: String?
    /// The keyword identifying the entity.
    public let keyword: String?
    /// The Unified Symbol Resolution (USR) string for the entity.
    public let usr: String?
    /// the byte location of the entity.
    public let offset: Offset?
    /// The byte length of the entity.
    public let length: Int?
    /// The XML representing the entity, its Unified Symbol Resolution (USR), etc.
    public let fullyAnnotatedDeclaration: String?
    /// The XML representing the entity and its documentation.
    ///
    /// - Note: Only present when the entity is documented.
    public let docFullAsXML: String?
    /// The entities the entity inherits from.
    public let inherits: [Inherit]?
    /// The entity's generic requirements.
    public let genericRequirements: [GenericRequirement]?
    /// The entity's generic parameters.
    public let genericParameters: [GenericParameter]?

    // MARK: SKSequence Protocol

    public var index: Int?
    public var filePath: String?
    public weak var internalParent: SKBaseEntity?
    public var internalChildren: [SKBaseEntity]?

    // MARK: - Public Initializers

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.kind = try container.decode(forKey: .kind)
        self.name = try container.decodeIfPresent(forKey: .name)
        self.keyword = try container.decodeIfPresent(forKey: .keyword)
        self.usr = try container.decodeIfPresent(forKey: .usr)
        self.offset = try container.decodeIfPresent(forKey: .offset)
        self.length = try container.decodeIfPresent(forKey: .length)
        self.fullyAnnotatedDeclaration = try container.decodeIfPresent(forKey: .fullyAnnotatedDeclaration)
        self.docFullAsXML = try container.decodeIfPresent(forKey: .docFullAsXML)
        self.inherits = try container.decodeIfPresent(forKey: .inherits)
        self.genericRequirements = try container.decodeIfPresent(forKey: .genericRequirements)
        self.genericParameters = try container.decodeIfPresent(forKey: .genericParameters)

        self.internalChildren = try decodeChildren(from: container)
    }

    // MARK: - SKSequence Protocol Methods

    open class func iteratorClass<T>() -> SKPreOrderDFSIterator<T>.Type {
        return SKPreOrderDFSIterator.self
    }

    // MARK: - Children Decoding Methods

    /// A convenience method for decoding children entities of a specified type from a decoding container.
    ///
    /// - Parameters:
    ///   - type: The child type.
    ///   - container: The decoding container.
    /// - Returns: The children substructures decoded as a specified type.
    /// - Throws: A `DecodingError`.
    public func decodeChildren<Entity: SKBaseEntity>(_ type: Entity.Type, from container: DecodingContainer) throws
        -> [Entity]? {
        return try container.decodeIfPresent([Entity].self, forKey: .internalChildren)
    }

    /// Decodes the children entities from a decoding container.
    ///
    /// If using a `SKBaseEntity` subclass, override this method and return the decoded children
    /// entities by calling `decodeChildren(_:from:)` with the respective subclass.
    ///
    /// For example:
    ///
    ///     override public func decodeChildren(from container: DecodingContainer) throws -> [SKBaseEntity]? {
    ///         return try decodeChildren(MyEntitySubclass.self, from: container)
    ///     }
    ///
    /// - Parameter container: The decoding container.
    /// - Returns: The children entities decoded as a specified type.
    /// - Throws: A `DecodingError`.
    open func decodeChildren(from container: DecodingContainer) throws -> [SKBaseEntity]? {
        return try decodeChildren(SKBaseEntity.self, from: container)
    }

    public static func == (lhs: SKBaseEntity, rhs: SKBaseEntity) -> Bool {
        return lhs.offset == rhs.offset
            && lhs.length == rhs.length
            && lhs.kind == rhs.kind
            && lhs.name == rhs.name
            && lhs.keyword == rhs.keyword
            && lhs.usr == rhs.usr
            && lhs.fullyAnnotatedDeclaration == rhs.fullyAnnotatedDeclaration
            && lhs.docFullAsXML == rhs.docFullAsXML
            && lhs.inherits == rhs.inherits
            && lhs.genericRequirements == rhs.genericRequirements
            && lhs.genericParameters == rhs.genericParameters
            && lhs.internalChildren == rhs.internalChildren
    }
}

// MARK: - Optional Byte Range Convertible Protocol

extension SKBaseEntity: OptionalByteRangeConvertible {}

// MARK: - JSON Debug String Convertible Protocol

extension SKBaseEntity: JSONDebugStringConvertible {}
