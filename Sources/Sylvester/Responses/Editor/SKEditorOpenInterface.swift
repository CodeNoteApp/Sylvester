import SylvesterEnumerations
import SourceKittenFramework
import MetaCodable

open class SKEditorOpenInterface: SKGenericEditorOpenInterface<SKSubstructure> {}

open class SKGenericEditorOpenInterface<Substructure: SKBaseSubstructure>: Codable, JSONDebugStringConvertible {
    public let sourceText: String

    public let topLevelSubstructures: SKChildren<Substructure>

    public let annotations: SKSortedEntities<SKAnnotation>

    public let syntaxMap: SyntaxMap

    public required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: SKKey.self)
        self.sourceText = try container.decode(String.self, forKey: .sourcetext)
        self.topLevelSubstructures = try container.decode(SKChildren<Substructure>.self, forKey: .substructure)
        self.annotations = try container.decode(SKSortedEntities<SKAnnotation>.self, forKey: .annotations)
        self.syntaxMap = try container.decode(SyntaxMap.self, forKey: .syntaxmap)
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: SKKey.self)
        try container.encode(sourceText, forKey: .sourcetext)
        try container.encode(topLevelSubstructures, forKey: .substructure)
        try container.encode(annotations, forKey: .annotations)
        try container.encode(syntaxMap, forKey: .syntaxmap)
    }
}
