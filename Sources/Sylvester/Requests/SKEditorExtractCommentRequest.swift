//
//  SKEditorExtractCommentRequest.swift
//
//
//  Created by JH on 2023/4/14.
//

import Foundation
import SourceKittenFramework
import SylvesterEnumerations

public class SKEditorExtractCommentRequest: SKRequestType {
    public typealias Response = SKSourceTextResponse

    public var requestKind: SKRequest { .editorExtractComment }
    
    public var sourceText: String

    public init(sourceText: String) {
        self.sourceText = sourceText
    }

    public var sourcekitObject: SourceKitObject {
        return [
            "key.request": requestKind,
            "key.sourcetext": sourceText,
        ]
    }
}
