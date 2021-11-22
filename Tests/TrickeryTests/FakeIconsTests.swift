import XCTest
@testable import Trickery
import SFSafeSymbols

class FakeIconsTests: XCTestCase {
    func test_sfSymbols() {
        Fake.Icons.sfSymbols.take().forEach {
            XCTAssertTrue(SFSymbol.allCases.contains($0))
        }
    }
}
