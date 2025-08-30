import SylvesterEnumerations
import SourceKittenFramework

public enum Utilities {
    public static func print(error: Error) {
        Swift.print(errorMessage(with: "\(error)"))
    }

    public static func errorMessage(with string: String) -> String {
        return "[Sylvester Error 😼] \(string)"
    }
}

@freestanding(expression)
public macro key<T: ExpressibleByStringLiteral>(_ key: SKKey) -> T = #externalMacro(module: "SylvesterMacros", type: "SKEnumerationsMacro")
