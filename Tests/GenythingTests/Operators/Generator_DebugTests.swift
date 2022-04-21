import Genything
import GenythingTest
import XCTest

final class Generator_DebugTests: XCTestCase {
    func test_debug_printsAsExpected() {
        _ = (1 ... 5).arbitrary
            .debug()
            .map { $0 * 2 }
            .debug("*2")
            .take(5, randomSource: .predetermined())
    }
}
