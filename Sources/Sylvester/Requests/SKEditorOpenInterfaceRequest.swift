//
//  SKEditorOpenInterfaceRequest.swift
//  Sylvester
//
//  Created by JH on 2025/8/30.
//

import Foundation
import SourceKittenFramework
import SylvesterEnumerations

public struct SKEditorOpenInterfaceRequest: SKRequestType {
    public typealias Response = SKEditorOpenInterface

    public let requestKind: SKRequest = .editorOpenInterface

    public var name: String

    public var moduleName: String

    public var compilerArguments: [String]

    public init(name: String = UUID().uuidString, moduleName: String, compilerArguments: [String] = [ "-sdk", sdkPath()]) {
        self.name = name
        self.moduleName = moduleName
        self.compilerArguments = compilerArguments
    }
    
    public var sourcekitObject: SourceKitObject {
        [
            "key.request": UID(requestKind.rawValue),
            "key.name": name,
            "key.modulename": moduleName,
            "key.compilerargs": compilerArguments,
        ]
    }
}
