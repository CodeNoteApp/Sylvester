import Foundation

public protocol ByteRangeConvertible {
    /// The byte offset of the entity inside the source contents.
    var offset: Offset { get }
    /// The byte length of the entity inside the source contents.
    var length: Int { get }
    /// The byte range (i.e. `offset..<length`).
    var byteRange: NSRange { get }
}

extension ByteRangeConvertible {
    public var byteRange: NSRange {
        return NSRange(location: offset, length: length)
    }
}
