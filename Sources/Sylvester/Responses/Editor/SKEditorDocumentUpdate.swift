//
//  SKDocumentUpdate.swift
//  
//
//  Created by JH on 2023/4/15.
//

import Foundation

class SKEditorDocumentUpdate: Codable {
    /// An array of annotations for the tokens of source text.
    public let annotations: SKSortedEntities<SKAnnotation>
    /// The Compiler diagnostics emitted during parsing of a source file.
    ///
    /// - Note: This key is only present if a diagnostic was emitted
    public let diagnostics: [SKDiagnostic]?
    
    /// The compiler [diagnostic stage](https://github.com/apple/swift/blob/master/docs/SIL.rst#sil-in-the-swift-compiler).
    public let diagnosticStage: SKDiagnosticStage
    
    enum CodingKeys: String, CodingKey {
        case annotations = "key.annotations"
        case diagnostics = "key.diagnostics"
        case diagnosticStage = "key.diagnostic_stage"
    }
}
