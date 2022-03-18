import XCTest
@testable import Genything

final internal class GenAllSatisfyTests: XCTestCase {
    func test_allSatisfy_true() {
        XCTAssertTrue(
            Generators.Zip(
                Generators.from(1...100),
                Generators.from(1...100)
            ).allSatisfy { a, b in
                a >= 1 && a <= 100 && b >= 1 && b <= 100
            }
        )
    }

    func test_allSatisfy_false() {
        XCTAssertFalse(
            Generators.from(1...100).allSatisfy { a in
                a < 1 || a > 100
            }
        )
    }
}
