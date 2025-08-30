//
//  Dictionary+Sylvester.swift
//  
//
//  Created by JH on 2023/4/15.
//

import Foundation
import SylvesterEnumerations

extension Dictionary where Key == String {
    subscript(key: SKKey) -> Value? {
        self[key.rawValue]
    }
}
