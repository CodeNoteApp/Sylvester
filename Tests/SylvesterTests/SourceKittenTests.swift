import Foundation
import Testing
import SourceKittenFramework
@testable import Sylvester
import SylvesterEnumerations

struct SourceKittenTests {
    @Test func editorOpenInterfaceRequest() async throws {
        let response = try await SylvesterInterface.shared.sendAsync(SKDocInfoRequest(file: .init(path: "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/System/Library/Frameworks/SwiftUICore.framework/Versions/A/Modules/SwiftUICore.swiftmodule/arm64e-apple-macos.swiftinterface"), moduleName: "SwiftUICore", compilerArguments: ["-sdk", sdkPath()]))
//        dump(response)
        print(response.sourceText)
    }
}
