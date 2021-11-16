import XCTest
@testable import Genything

final internal class GenAllSatisfyTests: XCTestCase {
    func test_allSatisfy_true() {
        XCTAssertTrue(
            Gen.zip(
                Gen.from(1...100),
                Gen.from(1...100)
            ).allSatisfy { a, b in
                a >= 1 && a <= 100 && b >= 1 && b <= 100
            }
        )
    }

    func test_allSatisfy_false() {
        XCTAssertFalse(
            Gen.from(1...100).allSatisfy { a in
                a < 1 || a > 100
            }
        )
    }
}
