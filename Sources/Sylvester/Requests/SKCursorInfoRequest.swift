import Foundation
import SourceKittenFramework
import SylvesterEnumerations

public class SKCursorInfoRequest: SKRequestType {
    public typealias Response = SKCursorInfo

    public var requestKind: SKRequest { .cursorinfo }

    public var file: File

    public var offset: Int?

    public var usr: String?

    public var compilerArguments: [String]

    public var cancelOnSubsequentRequest: Bool

    public init(file: File, offset: Int?, usr: String?, compilerArguments: [String], cancelOnSubsequentRequest: Bool) {
        self.file = file
        self.offset = offset
        self.usr = usr
        self.compilerArguments = compilerArguments
        self.cancelOnSubsequentRequest = cancelOnSubsequentRequest
    }

    public var sourcekitObject: SourceKitObject {
        let request: SourceKitObject = [
            "key.request": requestKind,
            "key.sourcefile": file.sourceKitPath,
            "key.compilerargs": compilerArguments,
            "key.cancel_on_subsequent_request": cancelOnSubsequentRequest.toInt,
        ]

        if file.path == nil {
            request.updateValue(file.contents, forKey: "key.sourcetext")
        }

        if let offset = offset {
            request.updateValue(offset, forKey: "key.offset")
        } else if let usr = usr {
            request.updateValue(usr, forKey: "key.usr")
        }

        return request
    }
}
