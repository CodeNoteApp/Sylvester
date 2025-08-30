import Foundation
import SwiftSyntax
import SwiftSyntaxMacros
@_spi(Macro) import SylvesterEnumerations

enum SKEnumerationsMacro: ExpressionMacro {
    static func expansion(of node: some SwiftSyntax.FreestandingMacroExpansionSyntax, in context: some SwiftSyntaxMacros.MacroExpansionContext) throws -> SwiftSyntax.ExprSyntax {
        // Ensure the macro is used with one argument.
        guard let argument = node.arguments.first?.expression else {
            throw MacroExpansionErrorMessage("Compiler error: Macro requires one argument.")
        }

        // The argument should be a member access expression, like `.diagnosticStage`.
        guard let memberAccessExpr = argument.as(MemberAccessExprSyntax.self) else {
            throw MacroExpansionErrorMessage("Compiler error: Argument must be an enum case (e.g., .myCase).")
        }

        // Extract the name of the enum case, e.g., "diagnosticStage".
        let caseName = memberAccessExpr.declName.baseName.text

        guard let finalKey = SKKey.caseMap[caseName] else {
            throw MacroExpansionErrorMessage("Error: No mapping found for enum case '\(caseName)'.")
        }

        // Return the string literal as a syntax node.
        return .init(StringLiteralExprSyntax(content: finalKey))
    }
}

