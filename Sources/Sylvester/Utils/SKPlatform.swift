import Foundation

public enum SKPlatform: String {
    case macOS = "macosx"
    case iOS = "iphoneos"
    case tvOS = "appletvos"
    case watchOS = "watchos"
    case driverKit = "driverkit"
    case tvOSSimulator = "appletvsimulator"
    case watchOSSimulator = "watchsimulator"
    case iOSSimulator = "iphonesimulator"

    var sdkPath: String {
        #if os(Linux)
        // xcrun does not exist on Linux
        return ""
        #else
//        TaskRunner().runTask(withCommand: "/usr/bin/xcrun", arguments: ["--show-sdk-path", "--sdk", rawValue]).output ?? ""
        return Exec.run("/usr/bin/xcrun", "--show-sdk-path", "--sdk", rawValue).string ?? ""
        #endif
    }
}
