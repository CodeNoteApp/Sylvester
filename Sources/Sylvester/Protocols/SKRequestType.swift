import Foundation
import SourceKittenFramework
import SylvesterEnumerations

public protocol SKRequestType {
    associatedtype Response: Decodable
    var requestKind: SKRequest { get }
    var sourcekitObject: SourceKitObject { get }
}
