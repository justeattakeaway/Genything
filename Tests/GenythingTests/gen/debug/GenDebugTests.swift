import XCTest
import Genything
import GenythingTest

class Gen_DebugTests: XCTestCase {
    func test_debug_printsAsExpected() {
        _ = Generators.from(1...5)
            .debug()
            .map { $0 * 2 }
            .debug("*2")
            .take(5)
    }
}
