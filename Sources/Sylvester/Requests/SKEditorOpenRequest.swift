//
//  SKEditorOpenRequest.swift
//
//
//  Created by JH on 2023/4/13.
//

import Foundation
import SourceKittenFramework

public class SKEditorOpenRequest: SKGenericEditorOpenRequest<SKSubstructure> {
    public typealias Response = SKEditorOpen
}

public class SKGenericEditorOpenRequest<Substructure: SKBaseSubstructure>: SKRequestType {
    public typealias Response = SKGenericEditorOpen<Substructure>

    public var file: File

    public var compilerArguments: [String]

    public init(file: File, compilerArguments: [String]) {
        self.file = file
        self.compilerArguments = compilerArguments
    }

    public var sourcekitObject: SourceKitObject {
        if let path = file.path {
            return [
                "key.request": UID("source.request.editor.open"),
                "key.name": path,
                "key.sourcefile": path,
                "key.compilerargs": compilerArguments + [path],
            ]
        } else {
            let name = String(abs(file.contents.hash))
            return [
                "key.request": UID("source.request.editor.open"),
                "key.name": name,
                "key.sourcetext": file.contents,
                "key.compilerargs": compilerArguments + [name],
            ]
        }
    }
}
