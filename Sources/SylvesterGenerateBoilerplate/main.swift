import Foundation
import OrderedCollections

let ignore: Set<String> = ["source.lang.swift.stmt"]
let prefixes: Set<String> = ["NS", "UI", "LLDB", "IB", "GK"]
let replacements: [String: String] = [
    "source.lang.swift.keyword.self": "keywordSelf",
    "source.lang.swift.keyword.Self": "keywordUppercaseSelf",
    "id": "ID",
    "url": "URL",
    "typeidentifier": "TypeIdentifier",
    "buildconfig": "BuildConfig",
    "pounddirective": "PoundDirective",
    "builtin": "BuiltIn",
    "doccomment": "DocComment",
    "objectliteral": "ObjectLiteral",
    "associatedtype": "AssociatedType",
    "precedencegroup": "PrecedenceGroup",
    "syntaxtype": "SyntaxType",
    "willset": "WillSet",
    "didset": "DidSet",
    "mutableaddress": "MutableAddress",
    "enumcase": "EnumCase",
    "enumelement": "EnumElement",
    "foreach": "ForEach",
    "repeatwhile": "RepeatWhile",
    "typeref": "TypeRef",
    "singlestatement": "SingleStatement",
    "singleexpression": "SingleExpression",
    "singledeclaration": "SingleDeclaration",
    "multistatement": "MultiStatement",
    "multitypememberdeclaration": "MultiTypeMemberDeclaration",
    "compilerargs": "CompilerArgs",
]

let keywords = [
    "__consuming",
    "__owned",
    "__setter_access",
    "__shared",
    "_alignment",
    "_backDeploy",
    "_borrow",
    "_borrowing",
    "_BridgeObject",
    "_cdecl",
    "_Class",
    "_compilerInitialized",
    "_const",
    "_consuming",
    "_documentation",
    "_dynamicReplacement",
    "_effects",
    "_expose",
    "_forward",
    "_implements",
    "_linear",
    "_local",
    "_modify",
    "_move",
    "_mutating",
    "_NativeClass",
    "_NativeRefCountedObject",
    "_noMetadata",
    "_nonSendable",
    "_objcImplementation",
    "_objcRuntimeName",
    "_opaqueReturnTypeOf",
    "_optimize",
    "_originallyDefinedIn",
    "_PackageDescription",
    "_private",
    "_projectedValueProperty",
    "_read",
    "_RefCountedObject",
    "_semantics",
    "_specialize",
    "_spi",
    "_spi_available",
    "_swift_native_objc_runtime_base",
    "_Trivial",
    "_TrivialAtMost",
    "_TrivialStride",
    "_typeEraser",
    "_unavailableFromAsync",
    "_underlyingVersion",
    "_UnknownLayout",
    "_version",
    "accesses",
    "actor",
    "addressWithNativeOwner",
    "addressWithOwner",
    "any",
    "Any",
    "as",
    "assignment",
    "associatedtype",
    "associativity",
    "async",
    "attached",
    "autoclosure",
    "availability",
    "available",
    "await",
    "backDeployed",
    "before",
    "block",
    "borrow",
    "borrowing",
    "break",
    "canImport",
    "case",
    "catch",
    "class",
    "compiler",
    "consume",
    "copy",
    "consuming",
    "continue",
    "convenience",
    "convention",
    "cType",
    "default",
    "defer",
    "deinit",
    "dependsOn",
    "deprecated",
    "derivative",
    "didSet",
    "differentiable",
    "distributed",
    "do",
    "dynamic",
    "each",
    "else",
    "enum",
    "escaping",
    "exclusivity",
    "exported",
    "extension",
    "fallthrough",
    "false",
    "file",
    "fileprivate",
    "final",
    "for",
    "discard",
    "forward",
    "func",
    "freestanding",
    "get",
    "guard",
    "higherThan",
    "if",
    "import",
    "in",
    "indirect",
    "infix",
    "init",
    "initializes",
    "inline",
    "inout",
    "internal",
    "introduced",
    "is",
    "isolated",
    "kind",
    "lazy",
    "left",
    "let",
    "line",
    "linear",
    "lowerThan",
    "macro",
    "message",
    "metadata",
    "modify",
    "module",
    "mutableAddressWithNativeOwner",
    "mutableAddressWithOwner",
    "mutating",
    "nil",
    "noasync",
    "noDerivative",
    "noescape",
    "none",
    "nonisolated",
    "nonmutating",
    "objc",
    "obsoleted",
    "of",
    "open",
    "operator",
    "optional",
    "override",
    "package",
    "postfix",
    "precedencegroup",
    "preconcurrency",
    "prefix",
    "private",
    "Protocol",
    "protocol",
    "public",
    "read",
    "reasync",
    "renamed",
    "repeat",
    "required",
    "rethrows",
    "retroactive",
    "return",
    "reverse",
    "right",
    "safe",
    "scoped",
    "self",
    "sending",
    "Self",
    "Sendable",
    "set",
    "some",
    "sourceFile",
    "spi",
    "spiModule",
    "static",
    "struct",
    "subscript",
    "super",
    "swift",
    "switch",
    "target",
    "then",
    "throw",
    "throws",
    "transpose",
    "true",
    "try",
    "Type",
    "typealias",
    "unavailable",
    "unchecked",
    "unowned",
    "unsafe",
    "unsafeAddress",
    "unsafeMutableAddress",
    "var",
    "visibility",
    "weak",
    "where",
    "while",
    "willSet",
    "witness_method",
    "wrt",
    "yield",
]

extension String {
//    var invertFirstLetterCasing: String {
//        let firstCharacterString = String(self.first!)
//        if firstCharacterString.lowercased() == firstCharacterString {
//            // First letter is lowercased.
//            return firstCharacterString.uppercased() + String(self.dropFirst())
//        } else {
//            // First letter is uppercased.
//            return firstCharacterString.lowercased() + String(self.dropFirst())
//        }
//    }

    var lowercaseFirstLetter: String {
        return String(first!).lowercased() + String(dropFirst())
    }

    var uppercaseFirstLetter: String {
        return String(first!).uppercased() + String(dropFirst())
    }
}

extension String {
    
       // MARK: - Public API

       /// Converts a string from snake_case or other delimited formats to camelCase.
       /// This is a convenience property that defaults to using the underscore `_` as the separator.
       ///
       ///     "__my_internal_var".camelCased -> "__myInternalVar"
       ///
       var camelCased: String {
           return self.camelCased(separators: "_")
       }

       /// Converts a string from a delimited format to camelCase, using a custom string of separators.
       ///
       /// - Parameter separators: A string containing all characters to be treated as separators (e.g., "-_").
       /// - Returns: The camelCased version of the string.
       ///
       ///     "__my-internal_var".camelCased(separators: "-_") -> "__myInternalVar"
       ///
       func camelCased(separators: String) -> String {
           return self.camelCased(separators: Set(separators))
       }

       // MARK: - Core Logic

       /// Converts a string from a delimited format to camelCase, using a custom set of separator characters.
       /// This is the core implementation. It preserves any leading separator characters.
       ///
       /// - Parameter separators: A set of characters to be treated as separators.
       /// - Returns: The camelCased version of the string.
       private func camelCased(separators: Set<Character>) -> String {
           // 1. Find the index of the first character that is NOT a separator.
           guard let firstNonSeparatorIndex = self.firstIndex(where: { !separators.contains($0) }) else {
               // If no such character exists, the string is either empty or consists only of separators.
               return self
           }

           // 2. Separate the leading separators from the rest of the string.
           let leadingSeparators = self[..<firstNonSeparatorIndex]
           let stringToProcess = self[firstNonSeparatorIndex...]

           // 3. Split the main part of the string by any of the specified separators.
           let components = stringToProcess.split(whereSeparator: { separators.contains($0) })
                                           .filter { !$0.isEmpty }

           // 4. If there are no valid components, return just the leading separators.
           guard let first = components.first else {
               return String(leadingSeparators)
           }
           
           // 5. If there's only one component, no further transformation is needed for the core part.
           if components.count == 1 {
               return String(leadingSeparators) + String(first)
           }

           // 6. Capitalize the remaining components.
           let remainingComponents = components.dropFirst()
           let capitalizedRemaining = remainingComponents.map { $0.capitalized }

           // 7. Join the first component (with its original casing) and the capitalized remaining components.
           let camelCasedCore = String(first) + capitalizedRemaining.joined()

           // 8. Prepend the leading separators back to the final result.
           return String(leadingSeparators) + camelCasedCore
       }
}

struct Boilerplate {
    class UID: Hashable {
        static var ignoreKeys: [String] = []

        let key: String
        let uniqueComponent: String

        func hash(into hasher: inout Hasher) {
            hasher.combine(key)
        }

        static func == (lhs: UID, rhs: UID) -> Bool {
            return lhs.key == rhs.key
        }

        var hasName: Bool {
            if name == nil {
                print("Skipping \"\(key)\"")
            }
            return name != nil
        }

        lazy var name: String? = {
            guard !UID.ignoreKeys.contains(key)
            else { print("Skipping key \"\(key)\""); return nil }

            if let hardcodedName = replacements[key] {
                return hardcodedName
            }

            let keyComponents = uniqueComponent.components(separatedBy: ".")

            // Filter out funky UIDs, such as `source.lang.swift.keyword._`.
            guard !keyComponents.isEmpty, !keyComponents.contains("_")
            else {
                return nil
            }

            var firstComponent = keyComponents.first!
            if let prefixString = prefixes.first(where: { firstComponent.hasPrefix($0) }),
               let prefixRange = firstComponent.range(of: prefixString) {
                firstComponent.replaceSubrange(prefixRange, with: prefixString.lowercased())
            }

            var name = ((replacements[firstComponent] ?? firstComponent) + keyComponents.dropFirst().map {
                if let replacement = replacements[$0] {
                    return replacement
                } else {
                    return $0.uppercaseFirstLetter
                }
            }.joined()).lowercaseFirstLetter

            if name.count <= 3 {
                name = name.lowercased()
            }

            name = name.camelCased(separators: "-_")

            guard !keywords.contains(name)
            else { return "`\(name)`" }

            return name
        }()

        init(key: String, uniqueComponent: String) {
            self.key = key
            self.uniqueComponent = uniqueComponent
        }
    }

    typealias EnumerationCase = (uniqueKeyComponent: String, regex: String)

    static let sourceKitServicePath = "/Applications/Xcode.app/Contents/Developer/Toolchains/"
        + "XcodeDefault.xctoolchain/usr/lib/sourcekitdInProc.framework/Versions/Current/sourcekitdInProc"

    let enumerationName: String
    var enumerationCaseTuples: [EnumerationCase]
    var enumerationCaseProtocols: [String]
    var ignoreKeys: [String]

    func generate() {
        var uidSets: [OrderedSet<UID>] = []

        UID.ignoreKeys = ignoreKeys

        for (uniqueKeyComponent, regex) in enumerationCaseTuples {
            let stringsOutput = Pipe()
            let grepOutput = Pipe()
            let uniqOutput = Pipe()

            let stringsProcess = Process()
            stringsProcess.launchPath = "/usr/bin/env"
            stringsProcess.arguments = [
                "strings",
                Boilerplate.sourceKitServicePath,
            ]
            stringsProcess.standardOutput = stringsOutput

            let grep = Process()
            grep.launchPath = "/usr/bin/env"
            grep.arguments = ["grep", uniqueKeyComponent]
            grep.standardInput = stringsOutput
            grep.standardOutput = grepOutput

            let uniq = Process()
            uniq.launchPath = "/usr/bin/env"
            uniq.arguments = ["uniq"]
            uniq.standardInput = grepOutput
            uniq.standardOutput = uniqOutput

            stringsProcess.launch()
            grep.launch()
            uniq.launch()
            uniq.waitUntilExit()

            let data = uniqOutput.fileHandleForReading.readDataToEndOfFile()
            guard let output = String(data: data, encoding: .utf8)
            else { return print("[Error] Could not convert data to UTF-8 string.") }

            let nsOutput = output as NSString
            // swiftlint:disable:next force_try
            let regularExpression = try! NSRegularExpression(pattern: regex, options: [.anchorsMatchLines])
            let range = NSRange(location: 0, length: output.utf16.count)
            var uidSet: OrderedSet<UID> = []
            regularExpression.enumerateMatches(
                in: output,
                options: [],
                range: range
            ) { match, _, _ in
                let key = nsOutput.substring(with: match!.range)

                guard !ignore.contains(key)
                else { return }

                let uniqueKeyComponent = nsOutput.substring(with: match!.range(at: 1))
                uidSet.append(UID(
                    key: key,
                    uniqueComponent: uniqueKeyComponent
                ))
            }

            uidSets.append(uidSet)
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.setLocalizedDateFormatFromTemplate("MM/dd/yyyy")
        let formattedDate = dateFormatter.string(from: Date())

        let customProtocols = enumerationCaseProtocols.isEmpty
            ? ""
            : ", " + enumerationCaseProtocols.joined(separator: " ,")
        let enumerationConformingProtocols = "String, Equatable, Codable, "
            + "CaseIterable, SourceKitUID\(customProtocols)"

        var enumerationCases = ""
        for (index, uidSet) in uidSets.enumerated() {
            if index != 0 {
                enumerationCases += "\n\n"
            }

            enumerationCases += uidSet.filter { $0.hasName }.map { """
                /// The `\($0.key)` SourceKit key.
                case \($0.name!) = \"\($0.key)\"
            """ }.joined(separator: "\n")
        }

        let enumDeclaration = """
        //  \(enumerationName).swift
        //  Sylvester 😼
        //
        //  Created by the 'generate_boilerplate.swift' script on \(formattedDate).

        /// - Warning: This enumeration is generated by the 'generate_boilerplate.swift' script.
        ///            You can update this enumeration by running `make generate-boilerplate`.
        public enum \(enumerationName): \(enumerationConformingProtocols) {
        \(enumerationCases)
        }
        """

        let currentDirectoryURL = URL(fileURLWithPath: #filePath).deletingLastPathComponent().deletingLastPathComponent().appendingPathComponent("Sylvester/Enumerations/Generated")
        let outputURL = URL(
            fileURLWithPath: "\(enumerationName).swift",
            isDirectory: false,
            relativeTo: currentDirectoryURL
        )

        print("Writing '\(enumerationName).swift' to \(outputURL.absoluteString)")

        do {
            try (enumDeclaration.trimmingCharacters(in: .whitespacesAndNewlines) + "\n")
                .write(to: outputURL, atomically: true, encoding: .utf8)
        } catch {
            print(error)
        }
    }
}

Boilerplate(
    enumerationName: "SKSourceKind",
    enumerationCaseTuples: [
        ("source.lang.swift", "^source\\.lang\\.swift\\.(.+)$"),
    ],
    enumerationCaseProtocols: [],
    ignoreKeys: ["source.lang.swift.codecomplete.group"]
).generate()

Boilerplate(
    enumerationName: "SKCodeCompletionContext",
    enumerationCaseTuples: [
        ("source.codecompletion.context", "^source\\.codecompletion\\.context\\.(.+)$"),
    ],
    enumerationCaseProtocols: [],
    ignoreKeys: []
).generate()

Boilerplate(
    enumerationName: "SKDiagnosticStage",
    enumerationCaseTuples: [
        ("source.diagnostic.stage.swift", "^source\\.diagnostic\\.stage\\.swift\\.(.+)$"),
    ],
    enumerationCaseProtocols: [],
    ignoreKeys: []
).generate()

Boilerplate(
    enumerationName: "SKAccessLevel",
    enumerationCaseTuples: [
        ("source.lang.swift.accessibility", "^source\\.lang\\.swift\\.accessibility\\.(.+)$"),
    ],
    enumerationCaseProtocols: [],
    ignoreKeys: []
).generate()

Boilerplate(
    enumerationName: "SKDeclarationKind",
    enumerationCaseTuples: [
        ("source.lang.swift.decl", "^source\\.lang\\.swift\\.decl\\.(.+)$"),
        ("source.lang.swift.syntaxtype", "^source\\.lang\\.swift\\.syntaxtype\\.(.+)$"),
        ("source.lang.swift.expr", "^source\\.lang\\.swift\\.(.+)$"),
        ("source.lang.swift.stmt", "^source\\.lang\\.swift\\.(.+)$"),
    ],
    enumerationCaseProtocols: [],
    ignoreKeys: []
).generate()

Boilerplate(
    enumerationName: "SKAttributeKind",
    enumerationCaseTuples: [
        ("source.decl.attribute", "^source\\.decl\\.attribute\\.(.+)$"),
    ],
    enumerationCaseProtocols: [],
    ignoreKeys: []
).generate()

Boilerplate(
    enumerationName: "SKElementKind",
    enumerationCaseTuples: [
        ("source.lang.swift.structure.elem", "^source\\.lang\\.swift\\.structure\\.elem\\.(.+)$"),
    ],
    enumerationCaseProtocols: [],
    ignoreKeys: []
).generate()

Boilerplate(
    enumerationName: "SKSyntaxKind",
    enumerationCaseTuples: [
        ("source.lang.swift.syntaxtype", "^source\\.lang\\.swift\\.syntaxtype\\.(.+)$"),
    ],
    enumerationCaseProtocols: [],
    ignoreKeys: []
).generate()

Boilerplate(
    enumerationName: "SKDiagnosticSeverity",
    enumerationCaseTuples: [
        ("source.diagnostic.severity", "^source\\.diagnostic\\.severity\\.(.+)$"),
    ],
    enumerationCaseProtocols: [],
    ignoreKeys: []
).generate()

Boilerplate(
    enumerationName: "SKKey",
    enumerationCaseTuples: [
        ("key", "^key\\.([a-z0-9_]+(?:\\.[a-z0-9_]+)*)$"),
    ],
    enumerationCaseProtocols: [],
    ignoreKeys: []
).generate()

Boilerplate(
    enumerationName: "SKNotificationKind",
    enumerationCaseTuples: [
        ("source.notification", "^source\\.notification\\.(.+)$"),
    ],
    enumerationCaseProtocols: [],
    ignoreKeys: []
).generate()

Boilerplate(
    enumerationName: "SKRequest",
    enumerationCaseTuples: [
        ("source.request", "^source\\.request\\.(.+)$"),
    ],
    enumerationCaseProtocols: [],
    ignoreKeys: []
).generate()
