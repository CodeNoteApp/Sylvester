/// Represents a _SourceKit_ YAML request.
open class SKYAMLRequest<Response: Decodable> {
    // MARK: - Public Stored Properties

    /// The response from the _SourceKit_ YAML request.
    public let response: Response

    // MARK: - Public Initializers

    /// Creates a new synchronous _SourceKit_ code completion request.
    ///
    /// - Warning: The request is sent synchronously, so ensure this initializer is not called on the main thread.
    ///
    /// - Parameters:
    ///   - yaml: The _SourceKit_ request in YAML representation.
    /// - Throws: A `SKError`, if an error occurs.
    public init(yaml: String) throws {
        self.response = try SylvesterInterface.shared.customYAML(yaml)
    }
}
