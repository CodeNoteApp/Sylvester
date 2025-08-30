import Foundation
import SwiftSyntaxMacros
import SwiftCompilerPlugin

@main
struct SylvesterMacros: CompilerPlugin {
    var providingMacros: [any Macro.Type] = [
        SKEnumerationsMacro.self,
    ]
}
