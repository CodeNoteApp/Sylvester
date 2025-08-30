//
//  SKSemanticTokensRequest.swift
//
//
//  Created by JH on 2023/4/15.
//

import Foundation
import SourceKittenFramework
import SylvesterEnumerations

/// Make the magic 0,0 replacetext request to update diagnostics and semantic tokens.
class SKEditorDocumentUpdateRequest: SKRequestType {
    typealias Response = SKEditorDocumentUpdate

    var requestKind: SKRequest { .editorReplacetext }
    
    var name: String

    init(name: String) {
        self.name = name
    }

    var sourcekitObject: SourceKitObject {
        [
            "key.request": requestKind,
            "key.name": name,
            "key.offset": 0,
            "key.length": 0,
            "key.sourcetext": "",
        ]
    }
}

extension SKRequest: SourceKitObjectConvertible {
    public var sourceKitObject: SourceKitObject? {
        UID(rawValue).sourceKitObject
    }
}
