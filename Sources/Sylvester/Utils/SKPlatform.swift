import Foundation

public enum SKPlatform: String {
    case macOS = "macosx"
    case iOS = "iphoneos"
    case tvOS = "appletvos"
    case watchOS = "watchos"
    case driverKit = "driverkit"
    case tvSimulator = "appletvsimulator"
    case watchSimulator = "watchsimulator"
    case iPhoneSimulator = "iphonesimulator"

    var sdkPath: String {
        #if os(Linux)
        // xcrun does not exist on Linux
        return ""
        #else
        return SourceKittenAdapter.xcRun(arguments: ["--show-sdk-path", "--sdk", rawValue]) ?? ""
        #endif
    }
}
