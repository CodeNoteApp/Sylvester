import Foundation
import Testing
import SourceKittenFramework
@testable import Sylvester
import SylvesterEnumerations

struct SourceKittenTests {
    @Test func editorOpenInterfaceRequest() async throws {
        let response = try await SylvesterInterface.shared.sendAsync(SKEditorOpenInterfaceRequest(moduleName: "CoreGraphics"))
        dump(response)
    }
}
