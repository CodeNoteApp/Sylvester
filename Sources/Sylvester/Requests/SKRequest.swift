//
//  SKRequest.swift
//  
//
//  Created by JH on 2023/4/13.
//

import Foundation
import SourceKittenFramework

public protocol SKRequest {
    associatedtype Response: SKResponse
    var sourcekitObject: SourceKitObject { get }
}
