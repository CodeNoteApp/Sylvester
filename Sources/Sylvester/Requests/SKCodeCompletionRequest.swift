import Foundation
import SourceKittenFramework
import SylvesterEnumerations

public class SKCodeCompletionRequest: SKRequestType {
    public typealias Response = SKCodeCompletion

    public var requestKind: SKRequest { .codecomplete }

    public var file: File

    public var offset: Offset

    public var compilerArguments: [String]

    public init(file: File, offset: Offset, compilerArguments: [String]) {
        self.file = file
        self.offset = offset
        self.compilerArguments = compilerArguments
    }

    public var sourcekitObject: SourceKitObject {
        let path = file.sourceKitPath
        var arguments = compilerArguments

        if !compilerArguments.contains("-c") {
            arguments.insert(contentsOf: ["-c", path], at: 0)
        }
        let request: SourceKitObject = [
            #key(.request): UID("source.request.codecomplete"),
            "key.sourcefile": path,
            "key.compilerargs": arguments,
            "key.offset": Int64(offset),
            "key.name": file.name,
            "key.toolchains": [
                "com.apple.dt.toolchain.XcodeDefault",
            ],
        ]

        if file.path == nil {
            request.updateValue(file.contents, forKey: "key.sourcetext")
        }

        return request
    }
}
