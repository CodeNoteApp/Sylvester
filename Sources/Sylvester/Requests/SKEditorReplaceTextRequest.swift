//
//  SKEditorReplaceTextRequest.swift
//
//
//  Created by JH on 2023/4/15.
//

import Foundation
import SourceKittenFramework
import SylvesterEnumerations

public class SKEditorReplaceTextRequest: SKGenericEditorReplaceTextRequest<SKSubstructure> {}

public class SKGenericEditorReplaceTextRequest<Substructure: SKBaseSubstructure>: SKRequestType {
    public typealias Response = SKGenericEditorReplaceText<SKBaseSubstructure>

    public var requestKind: SKRequest { .editorReplacetext }
    
    public var name: String

    public var offset: Int

    public var length: Int

    public var sourceText: String

    public init(name: String, offset: Int, length: Int, sourceText: String) {
        self.name = name
        self.offset = offset
        self.length = length
        self.sourceText = sourceText
    }

    public var sourcekitObject: SourceKitObject {
        [
            "key.request": requestKind,
            "key.name": name,
            "key.offset": offset,
            "key.length": length,
            "key.sourcetext": sourceText,
        ]
    }
}


