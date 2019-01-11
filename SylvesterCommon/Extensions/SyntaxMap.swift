//
//  SyntaxMap.swift
//  Sylvester 😼
//
//  Created by Chris Zielinski on 12/3/18.
//  Copyright © 2018 Big Z Labs. All rights reserved.
//

import SourceKittenFramework

public enum SwiftDocsCodingKey: String, CodingKey {
    case file
    case response
}

extension SwiftDocs: Encodable {

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: SwiftDocsCodingKey.self)
        try container.encode(file, forKey: .file)

        guard JSONSerialization.isValidJSONObject(docsDictionary),
            let data = try? JSONSerialization.data(withJSONObject: docsDictionary)
            else { throw SKError.jsonDataEncodingFailed }
        try container.encode(data, forKey: .response)
    }

}

extension SyntaxMap: Codable {

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.init(tokens: try container.decode())
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        try container.encode(contentsOf: tokens)
    }

}
