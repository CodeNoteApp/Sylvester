import Foundation
import MetaCodable
import SylvesterEnumerations

// swiftlint:disable line_length
/// Represents the structure of a symbol.
///
/// Depending on the request, the structure may contain syntactic and semantic information.
///
///
/// ## Subclassing
///
/// Fancy your own subclass? No problem.
///
/// ```
/// final class BetterSubstructureSubclass: SKBaseSubstructure, SKFinalSubclass {
///
///     var iAmAnImportantProperty: String = "🚶‍♂️"
///
///     public override func decodeChildren(from container: DecodingContainer) throws -> [SKBaseSubstructure]? {
///         return try decodeChildren(BetterSubstructureSubclass.self, from: container)
///     }
///
///     /// The default iterator for `SKChildren` does a pre-order (NLR) depth-first search (DFS) traversal; however, if you want something else, for instance:
///     class FunctionSubstructureIterator<Substructure: BetterSubstructureSubclass>: SKPreOrderDFSIterator<Substructure> {
///
///         override func next() -> Substructure? {
///             guard let nextSubstructure = super.next()
///                 else { return nil }
///
///             if nextSubstructure.isFunction {
///                 return nextSubstructure
///             } else {
///                 return next()
///             }
///         }
///
///     }
///
///     override class func iteratorClass<Substructure: BetterSubstructureSubclass>() -> SKPreOrderDFSIterator<Substructure>.Type {
///         return FunctionSubstructureIterator.self
///     }
///
/// }
/// ```
///
// @Codable
open class SKBaseSubstructure: SKSequence {
    // swiftlint:enable line_length

    // MARK: - Internal Declarations

    public enum CodingKeys: String, CodingKey {
        case accessibility = "key.accessibility"
        case annotatedDeclaration = "key.annotated_decl"
        case attributes = "key.attributes"
        case bodyLength = "key.bodylength"
        case bodyOffset = "key.bodyoffset"
        case docColumn = "key.doc.column"
        case docComment = "key.doc.comment"
        case docDeclaration = "key.doc.declaration"
        case docFile = "key.doc.file"
        case docFullAsXML = "key.doc.full_as_xml"
        case docLine = "key.doc.line"
        case docName = "key.doc.name"
        case docParameters = "key.doc.parameters"
        case docType = "key.doc.type"
        case docLength = "key.doclength"
        case docOffset = "key.docoffset"
        case elements = "key.elements"
        case filePath = "key.filepath"
        case fullyAnnotatedDeclaration = "key.fully_annotated_decl"
        case inheritedTypes = "key.inheritedtypes"
        case kind = "key.kind"
        case length = "key.length"
        case name = "key.name"
        case nameLength = "key.namelength"
        case nameOffset = "key.nameoffset"
        case offset = "key.offset"
        case parsedDeclaration = "key.parsed_declaration"
        case parsedScopeEnd = "key.parsed_scope.end"
        case parsedScopeStart = "key.parsed_scope.start"
        case runtimeName = "key.runtime_name"
        case overrides = "key.overrides"
        case setterAccessibility = "key.setter_accessibility"
        case internalChildren = "key.substructure"
        case typeName = "key.typename"
        case typeUSR = "key.typeusr"
        case usr = "key.usr"
    }

    // MARK: - Public Type Aliases

    public typealias AccessLevel = SKAccessLevel
    public typealias Attribute = SKAttribute
    public typealias DocumentationParameter = SKDocumentationParameter
    public typealias Element = SKElement
    public typealias InheritedType = SKInheritedType
    public typealias Override = SKOverride
    public typealias Kind = SKDeclarationKind
    public typealias DecodingContainer = KeyedDecodingContainer<SKBaseSubstructure.CodingKeys>

    // MARK: - Public Stored Properties

    /// The [access level](https://docs.swift.org/swift-book/LanguageGuide/AccessControl.html) of the substructure.
    public let accessibility: AccessLevel?
    /// The XML representing how the substructure was declared.
    public let annotatedDeclaration: String?
    /// The [attributes](https://docs.swift.org/swift-book/ReferenceManual/Attributes.html) of the substructure.
    ///
    /// The attributes include prefixed keywords such as `override`.
    ///
    /// - Note: The attributes are ordered by increasing byte offset (i.e. the first attribute in the source
    ///         is the first element in the array).
    public let attributes: SKSortedEntities<Attribute>?
    /// The byte offset of the substructure's body inside the source contents.
    public let bodyOffset: Int?
    /// The byte length of the substructure's body inside the source contents.
    public let bodyLength: Int?
    /// The column where the token's declaration begins (`Int64`).
    ///
    /// - Note: Resolved by `SourceKitten` for a _SwiftDocs_ request. Mileage may vary.
    ///
    public let docColumn: Int?
    /// The documentation comment.
    ///
    /// - Note: Resolved by `SourceKitten` for a _SwiftDocs_ request. Mileage may vary.
    ///
    public let docComment: String?
    /// The declaration of documented token.
    ///
    /// - Note: Resolved by `SourceKitten` for a _SwiftDocs_ request. Mileage may vary.
    ///
    public let docDeclaration: String?
    /// The file where the documented token is located.
    ///
    /// - Note: Resolved by `SourceKitten` for a _SwiftDocs_ request. Mileage may vary.
    ///
    public let docFile: String?
    /// The XML representing the substructure and its documentation.
    ///
    /// Only present when the substructure is documented.
    ///
    /// - Note: Resolved by `SourceKitten` for a _SwiftDocs_ request.
    ///
    public let docFullAsXML: String?
    /// The line where the token's declaration begins (Int64).
    ///
    /// - Note: Resolved by `SourceKitten` for a _SwiftDocs_ request. Mileage may vary.
    ///
    public let docLine: Int?
    /// The name of the documented token (String).
    ///
    /// - Note: Resolved by `SourceKitten` for a _SwiftDocs_ request. Mileage may vary.
    ///
    public let docName: String?
    /// The parameters of the documented token.
    ///
    /// - Note: Resolved by `SourceKitten` for a _SwiftDocs_ request. Mileage **will** vary.
    ///   Not recommended for use.
    ///
    public let docParameters: [DocumentationParameter]?
    /// The type of the documented token.
    ///
    /// - Note: Resolved by `SourceKitten` for a _SwiftDocs_ request. Mileage may vary.
    ///
    public let docType: String?
    /// The byte offset of the substructure's documentation inside the source contents.
    public let docOffset: Int?
    /// The byte length of the substructure's documentation inside the source contents.
    public let docLength: Int?
    /// The elements of the substructure.
    ///
    /// - Note: The elements are ordered by increasing byte offset (i.e. the first element in the source
    ///         is the first element in the array).
    public let elements: SKSortedEntities<Element>?
    /// The XML representing the substructure.
    public let fullyAnnotatedDeclaration: String?
    /// The inherited types of the substructure.
    ///
    /// Only present when the response is from a `SKSwiftDocumentation` request.
    public let inheritedTypes: [InheritedType]?
    /// The UID for the declaration or reference kind (function, class, etc.).
    public let kind: Kind
    /// The byte offset of the substructure inside the source contents.
    ///
    /// This offset is the location of the substructure's declarative keyword (e.g. `class`, `let`, `func`, etc.).
    public let offset: Offset
    /// The byte length of the substructure inside the source contents.
    ///
    /// The length includes the substructure's body, if present.
    public let length: Int
    /// The display name for the substructure.
    public let name: String?
    /// The byte offset of the substructure's name inside the source contents.
    public let nameOffset: Int?
    /// The byte length of the substructure's name inside the source contents.
    ///
    /// For a function, the name encompasses everything up to the closing parameter `)`, including the generic
    /// parameter clause `<...>`.
    public let nameLength: Int?
    /// The parsed declaration.
    public let parsedDeclaration: String?
    /// The parsed scope end (Int64).
    public let parsedScopeEnd: Int?
    /// The parsed scope start (Int64).
    public let parsedScopeStart: Int?
    /// The objective-c runtime name.
    public let runtimeName: String?
    /// The overrides of the substructure.
    public let overrides: [Override]?
    /// The setter access level.
    public let setterAccessibility: AccessLevel?
    /// A string describing the type of the substructure.
    public let typeName: String?
    /// The Unified Symbol Resolution (USR) for the substructure's type.
    public let typeUSR: String?
    /// The Unified Symbol Resolution (USR) for the substructure.
    public let usr: String?

    // MARK: SKSequence Protocol

    public var index: Int?
    public var filePath: String?
    public weak var internalParent: SKBaseSubstructure?
    public var internalChildren: [SKBaseSubstructure]?

    // MARK: - Public Initializers

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.accessibility = try container.decodeIfPresent(forKey: .accessibility)
        self.annotatedDeclaration = try container.decodeIfPresent(forKey: .annotatedDeclaration)
        self.attributes = try container.decodeIfPresent(forKey: .attributes)
        self.bodyOffset = try container.decodeIfPresent(forKey: .bodyOffset)
        self.bodyLength = try container.decodeIfPresent(forKey: .bodyLength)
        self.docColumn = try container.decodeIfPresent(forKey: .docColumn)
        self.docComment = try container.decodeIfPresent(forKey: .docComment)
        self.docDeclaration = try container.decodeIfPresent(forKey: .docDeclaration)
        self.docFile = try container.decodeIfPresent(forKey: .docFile)
        self.docFullAsXML = try container.decodeIfPresent(forKey: .docFullAsXML)
        self.docLine = try container.decodeIfPresent(forKey: .docLine)
        self.docName = try container.decodeIfPresent(forKey: .docName)
        self.docParameters = try container.decodeIfPresent(forKey: .docParameters)
        self.docType = try container.decodeIfPresent(forKey: .docType)
        self.docOffset = try container.decodeIfPresent(forKey: .docOffset)
        self.docLength = try container.decodeIfPresent(forKey: .docLength)
        self.elements = try container.decodeIfPresent(forKey: .elements)
        self.filePath = try container.decodeIfPresent(forKey: .filePath)
        self.fullyAnnotatedDeclaration = try container.decodeIfPresent(forKey: .fullyAnnotatedDeclaration)
        self.inheritedTypes = try container.decodeIfPresent(forKey: .inheritedTypes)

        self.kind = try container.decode(forKey: .kind)
        self.offset = try container.decode(forKey: .offset)
        self.length = try container.decode(forKey: .length)

        self.name = try container.decodeIfPresent(forKey: .name)
        self.nameOffset = try container.decodeIfPresent(forKey: .nameOffset)
        self.nameLength = try container.decodeIfPresent(forKey: .nameLength)
        self.parsedDeclaration = try container.decodeIfPresent(forKey: .parsedDeclaration)
        self.parsedScopeEnd = try container.decodeIfPresent(forKey: .parsedScopeEnd)
        self.parsedScopeStart = try container.decodeIfPresent(forKey: .parsedScopeStart)
        self.runtimeName = try container.decodeIfPresent(forKey: .runtimeName)
        self.overrides = try container.decodeIfPresent(forKey: .overrides)
        self.setterAccessibility = try container.decodeIfPresent(forKey: .setterAccessibility)
        self.typeName = try container.decodeIfPresent(forKey: .typeName)
        self.typeUSR = try container.decodeIfPresent(forKey: .typeUSR)
        self.usr = try container.decodeIfPresent(forKey: .usr)
        self.internalChildren = try decodeChildren(from: container)
    }

    // MARK: - Public Lazy Stored Properties

    /// Whether the substructure has a body (i.e. `bodyOffset` and `bodyLength` are non-nil).
    open lazy var hasBody: Bool = bodyByteRange != nil

    /// The byte range of the substructure (i.e. `offset` and `length`).
    ///
    /// Unlike `contentByteRange`, this range does not include the attributes.
    open lazy var byteRange: NSRange = .init(location: offset, length: length)

    /// The byte range of the substructure's name (i.e. `nameOffset` and `nameLength`).
    ///
    /// For a function, the name byte offset encompasses everything up to the closing parameter
    /// parenthesis `)`, including the generic parameter clause `<...>`.
    open lazy var nameByteRange: NSRange? = {
        guard let nameOffset = nameOffset,
              let nameLength = nameLength,
              nameOffset != 0, nameLength != 0
        else { return nil }
        return NSRange(location: nameOffset, length: nameLength)
    }()

    /// The byte range of the substructure's body (i.e. `bodyOffset` and `bodyLength`).
    open lazy var bodyByteRange: NSRange? = {
        guard let bodyOffset = bodyOffset, let bodyLength = bodyLength
        else { return nil }
        return NSRange(location: bodyOffset, length: bodyLength)
    }()

    /// The byte range encompassing the entire substructure content, including any attributes.
    open lazy var contentByteRange: NSRange = {
        let startingOffset: Offset
        if let attributeOffset = attributes?.first?.offset {
            // In the case of a structure like `static public func`, `offset` identifies the position of `static`
            // whereas the first attribute identifies the position of `public`. Thus, we need to use the minimum.
            startingOffset = min(attributeOffset, offset)
        } else {
            startingOffset = offset
        }

        return NSRange(startingOffset ..< (offset + length))
    }()

    /// Whether the substructure is a function-kind and has a return type.
    open lazy var isReturningFunction: Bool = functionReturnType != nil

    /// Returns the return type (`typeName`) of a function-kind substructure.
    open lazy var functionReturnType: String? = {
        guard isFunction
        else { return nil }
        return typeName
    }()

    // swiftlint:disable:next todo
    /// Whether the substructure is a mark delimiter, which are `TODO`, `FIXME`, and `MARK`.
    open lazy var isMark: Bool = kind == .commentMark

    /// Whether the substructure is a protocol or protocol extension.
    open lazy var isProtocol: Bool = {
        switch kind {
        case .protocol,
             .extensionProtocol:
            return true
        default:
            return false
        }
    }()

    /// Whether the substructure is a class-kind.
    ///
    /// Class-kinds are:
    ///  * `.class`
    ///  * `.varClass`
    ///  * `.extensionClass`
    ///  * `.functionMethodClass`
    ///
    open lazy var isClass: Bool = {
        switch kind {
        case .class,
             .varClass,
             .extensionClass,
             .functionMethodClass:
            return true
        default:
            return false
        }
    }()

    /// Whether the substructure is an extension-kind.
    ///
    /// Extension-kinds are:
    ///  * `.extension`
    ///  * `.extensionClass`
    ///  * `.extensionEnum`
    ///  * `.extensionStruct`
    ///  * `.extensionProtocol`
    ///
    open lazy var isExtension: Bool = {
        switch kind {
        case .extension,
             .extensionClass,
             .extensionEnum,
             .extensionStruct,
             .extensionProtocol:
            return true
        default:
            return false
        }
    }()

    /// Whether the substructure is a variable-kind.
    ///
    /// Variable-kinds are:
    ///  * `.varLocal`
    ///  * `.varInstance`
    ///  * `.varClass`
    ///  * `.varStatic`
    ///  * `.varGlobal`
    ///
    open lazy var isVariable: Bool = {
        switch kind {
        case .varLocal,
             .varInstance,
             .varClass,
             .varStatic,
             .varGlobal:
            return true
        default:
            return false
        }
    }()

    /// Whether the substructure is a function-kind.
    ///
    /// Function-kinds are:
    ///  * `.functionMethodInstance`
    ///  * `.functionMethodClass`
    ///  * `.functionMethodStatic`
    ///  * `.functionFree`
    ///
    open lazy var isFunction: Bool = {
        switch kind {
        case .functionMethodInstance,
             .functionMethodClass,
             .functionMethodStatic,
             .functionFree:
            return true
        default:
            return false
        }
    }()

    /// Whether the substructure is an overridden function.
    open lazy var isOverride: Bool = attributes?.containsAttribute(with: .override) ?? false

    /// Whether the substructure's parent is a protocol declaration.
    open lazy var isInsideProtocolDeclaration: Bool = internalParent?.kind == .protocol

    // MARK: - SKSequence Protocol Methods

    open class func iteratorClass<T>() -> SKPreOrderDFSIterator<T>.Type {
        return SKPreOrderDFSIterator.self
    }

    // MARK: - Children Decoding Methods

    /// A convenience method for decoding children substructures of a specified type from a decoding container.
    ///
    /// - Parameters:
    ///   - type: The child type.
    ///   - container: The decoding container.
    /// - Returns: The children substructures decoded as a specified type.
    /// - Throws: A `DecodingError`.
    public func decodeChildren<Substructure: SKBaseSubstructure>(
        _ type: Substructure.Type,
        from container: DecodingContainer
    ) throws
        -> [Substructure]? {
        return try container.decodeIfPresent([Substructure].self, forKey: .internalChildren)
    }

    /// Decodes the children substructures from a decoding container.
    ///
    /// If using a `SKBaseSubstructure` subclass, override this method and return the decoded children
    /// substructures by calling `decodeChildren(_:from:)` with the respective subclass.
    ///
    /// For example:
    ///
    ///     override public func decodeChildren(from container: DecodingContainer) throws -> [SKBaseSubstructure]? {
    ///         return try decodeChildren(MySubstructureSubclass.self, from: container)
    ///     }
    ///
    /// - Parameter container: The decoding container.
    /// - Returns: The children substructures decoded as a specified type.
    /// - Throws: A `DecodingError`.
    open func decodeChildren(from container: DecodingContainer) throws -> [SKBaseSubstructure]? {
        return try decodeChildren(SKBaseSubstructure.self, from: container)
    }

    public static func == (lhs: SKBaseSubstructure, rhs: SKBaseSubstructure) -> Bool {
        return lhs.offset == rhs.offset
            && lhs.accessibility == rhs.accessibility
            && lhs.annotatedDeclaration == rhs.annotatedDeclaration
            && lhs.attributes == rhs.attributes
            && lhs.bodyOffset == rhs.bodyOffset
            && lhs.bodyLength == rhs.bodyLength
            && lhs.docColumn == rhs.docColumn
            && lhs.docComment == rhs.docComment
            && lhs.docDeclaration == rhs.docDeclaration
            && lhs.docFile == rhs.docFile
            && lhs.docFullAsXML == rhs.docFullAsXML
            && lhs.docLine == rhs.docLine
            && lhs.docName == rhs.docName
            && lhs.docParameters == rhs.docParameters
            && lhs.docType == rhs.docType
            && lhs.docOffset == rhs.docOffset
            && lhs.docLength == rhs.docLength
            && lhs.elements == rhs.elements
            && lhs.fullyAnnotatedDeclaration == rhs.fullyAnnotatedDeclaration
            && lhs.inheritedTypes == rhs.inheritedTypes
            && lhs.kind == rhs.kind
            && lhs.length == rhs.length
            && lhs.name == rhs.name
            && lhs.nameOffset == rhs.nameOffset
            && lhs.nameLength == rhs.nameLength
            && lhs.parsedDeclaration == rhs.parsedDeclaration
            && lhs.parsedScopeEnd == rhs.parsedScopeEnd
            && lhs.parsedScopeStart == rhs.parsedScopeStart
            && lhs.runtimeName == rhs.runtimeName
            && lhs.overrides == rhs.overrides
            && lhs.setterAccessibility == rhs.setterAccessibility
            && lhs.internalChildren == rhs.internalChildren
            && lhs.typeName == rhs.typeName
            && lhs.typeUSR == rhs.typeUSR
            && lhs.usr == rhs.usr
    }
}

// MARK: - JSON Debug String Convertible Protocol

extension SKBaseSubstructure: JSONDebugStringConvertible {}
