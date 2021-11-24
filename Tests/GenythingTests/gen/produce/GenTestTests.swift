import XCTest
@testable import Genything

final internal class GenTestTests: XCTestCase {
    func test_that_a_generator_test_succeeds_when_it_should() {
        let result = Gen.zip(
            Gen.from(1...100),
            Gen.from(1...100)
        ).test { a, b in
            a >= 1 && a <= 100 && b >= 1 && b <= 100
        }

        XCTAssertTrue(result.isSuccess)
    }

    func test_that_a_generator_test_fails_when_it_should() {
        let result = Gen.from(1...100).test { a in
            a < 1 || a > 100
        }

        XCTAssertFalse(result.isSuccess)
    }
}
