//
//  SKGenericDocInfoRequest.swift
//
//
//  Created by JH on 2023/4/14.
//

import Foundation
import SourceKittenFramework

public class SKDocInfoRequest: SKGenericDocInfoRequest<SKEntity> {
    public typealias Response = SKDocInfo
}

public class SKGenericDocInfoRequest<Entity: SKBaseEntity>: SKRequestType {
    public typealias Response = SKGenericDocInfo<Entity>

    public var file: File?

    public var moduleName: String?

    public var compilerArguments: [String]

    public init(file: File?, moduleName: String?, compilerArguments: [String]) {
        self.file = file
        self.moduleName = moduleName
        self.compilerArguments = compilerArguments
    }

    public var sourcekitObject: SourceKitObject {
        let request: SourceKitObject = [
            "key.request": UID("source.request.docinfo"),
            "key.compilerargs": compilerArguments,
        ]

        if let moduleName = moduleName {
            request.updateValue(moduleName, forKey: "key.modulename")
        } else if let absolutePath = file?.path {
            request.updateValue(absolutePath, forKey: "key.sourcefile")
        } else if let contents = file?.contents {
            request.updateValue(contents, forKey: "key.sourcetext")
        }

        return request
    }
}
