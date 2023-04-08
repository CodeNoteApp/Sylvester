//
//  SKModuleWrapper.swift
//  SylvesterCommon 😼
//
//  Created by Chris Zielinski on 12/12/18.
//  Copyright © 2018 Big Z Labs. All rights reserved.
//

import SourceKittenFramework

@objc
public class SKModuleWrapper: SKDataWrapper {

    // MARK: - Public Static Computed Properties

    public override class var supportsSecureCoding: Bool {
        return true
    }

    // MARK: - Public Initializers

    /// Creates a new module wrapper.
    ///
    /// - Parameter module: The module to wrap.
    /// - Throws: A `SKError` if encoding fails.
    public convenience init(module: Module) throws {
        do {
            try self.init(object: module)
        } catch {
            throw error.toSKError()
        }
    }

    // MARK: - Public Decoding Methods

    /// The wrapped `Module`.
    ///
    /// - Returns: The wrapped `Module`.
    /// - Throws: A `SKError` if decoding fails.
    public func module() throws -> Module {
        return try decodeData()
    }

}
