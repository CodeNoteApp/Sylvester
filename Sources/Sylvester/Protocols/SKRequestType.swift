//
//  SKRequest.swift
//  
//
//  Created by JH on 2023/4/13.
//

import Foundation
import SourceKittenFramework

public protocol SKRequestType {
    associatedtype Response: Decodable
    var sourcekitObject: SourceKitObject { get }
}
