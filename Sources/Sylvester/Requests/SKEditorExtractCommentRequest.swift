//
//  SKEditorExtractCommentRequest.swift
//
//
//  Created by JH on 2023/4/14.
//

import Foundation
import SourceKittenFramework

public class SKEditorExtractCommentRequest: SKRequestType {
    public typealias Response = SKSourceTextResponse

    public var sourceText: String

    public init(sourceText: String) {
        self.sourceText = sourceText
    }

    public var sourcekitObject: SourceKitObject {
        return [
            "key.request": UID("source.request.editor.extract.comment"),
            "key.sourcetext": sourceText,
        ]
    }
}
