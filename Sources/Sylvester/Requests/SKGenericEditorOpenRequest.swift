//
//  SKGenericEditorOpenRequest.swift
//
//
//  Created by JH on 2023/4/13.
//

import Foundation
import SourceKittenFramework

class SKGenericEditorOpenRequest<Substructure: SKBaseSubstructure>: SKRequest {
    typealias Response = SKGenericEditorOpen<Substructure>

    var file: File

    var compilerArguments: [String]

    init(file: File, compilerArguments: [String]) {
        self.file = file
        self.compilerArguments = compilerArguments
    }

    var sourcekitObject: SourceKitObject {
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
