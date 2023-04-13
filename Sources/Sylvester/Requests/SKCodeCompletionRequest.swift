//
//  SKCodeCompletionRequest.swift
//
//
//  Created by JH on 2023/4/13.
//

import Foundation
import SourceKittenFramework

class SKCodeCompletionRequest: SKRequest {
    typealias Response = SKCodeCompletion

    var file: File

    var offset: Offset

    var compilerArguments: [String]

    init(file: File, offset: Offset, compilerArguments: [String]) {
        self.file = file
        self.offset = offset
        self.compilerArguments = compilerArguments
    }

    var sourcekitObject: SourceKitObject {
        let path = file.sourceKitPath
        var arguments = compilerArguments

        if !compilerArguments.contains("-c") {
            arguments.insert(contentsOf: ["-c", path], at: 0)
        }

        let request: SourceKitObject = [
            "key.request": UID("source.request.codecomplete"),
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
