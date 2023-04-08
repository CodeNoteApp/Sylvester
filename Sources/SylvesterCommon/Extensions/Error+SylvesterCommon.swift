//
//  Error.swift
//  SylvesterCommon 😼
//
//  Created by Chris Zielinski on 12/15/18.
//  Copyright © 2018 Big Z Labs. All rights reserved.
//

public extension Error {

    /// The receiver is expected to already be a `SKError`.
    /// If the receiver is neither, it is wrapped in a `SKError.unknown` error.
    ///
    /// - Returns: The error as a `SKError`.
    func toSKError() -> SKError {
        if let skError = self as? SKError {
            return skError
        }

        return SKError.unknown(error: self)
    }

}
