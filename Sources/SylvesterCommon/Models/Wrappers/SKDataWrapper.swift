//
//  SKDataWrapper.swift
//  SylvesterCommon 😼
//
//  Created by Chris Zielinski on 12/11/18.
//  Copyright © 2018 Big Z Labs. All rights reserved.
//

import SourceKittenFramework

@objc
public class SKDataWrapper: NSObject, NSSecureCoding {

    // MARK: - Internal Declarations

    enum CodingKeys: String, CodingKey {
        case data
    }

    // MARK: - Public Static Computed Properties

    public class var supportsSecureCoding: Bool {
        return true
    }

    // MARK: - Public Stored Properties

    public let data: Data

    // MARK: - Public Initializers

    public init(data: Data) {
        self.data = data
    }

    public required init?(coder aDecoder: NSCoder) {
        guard let data = aDecoder.decodeObject(of: NSData.self, forKey: CodingKeys.data.rawValue)
            else { return nil }
        self.data = data as Data
    }

    /// Creates a new data wrapper for an `Encodable` object.
    ///
    /// - Parameter object: The object to encode and store.
    /// - Throws: A `SKError`, if encoding fails.
    public convenience init<T: Encodable>(object: T) throws {
        do {
            self.init(data: try JSONEncoder().encode(object))
        } catch {
            throw error.toSKError()
        }
    }

    /// A convenience initializer that tries to create a data wrapper from an object.
    ///
    /// - Parameter object: The object to encode.
    /// - Throws: An `SKError` if encoding fails.
    public convenience init(_ object: SourceKitRepresentable) throws {
        guard JSONSerialization.isValidJSONObject(object),
            let data = try? JSONSerialization.data(withJSONObject: object)
            else { throw SKError.jsonDataEncodingFailed }
        self.init(data: data)
    }

    // MARK: - Coding Protocol

    public func encode(with aCoder: NSCoder) {
        aCoder.encode(data as NSData, forKey: CodingKeys.data.rawValue)
    }

    // MARK: - Public Decoding Methods

    /// Returns a value of the type you specify, decoded from this wrapper's data.
    ///
    /// - Returns: A value of the requested type.
    /// - Throws: A `SKError`, if decoding fails.
    public func decodeData<T: Decodable>() throws -> T {
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw error.toSKError()
        }
    }

}
