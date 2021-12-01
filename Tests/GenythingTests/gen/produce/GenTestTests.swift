import XCTest
@testable import Genything
@testable import GenythingTest

final internal class GenTestTests: XCTestCase {
    func test_that_a_generator_test_succeeds_when_it_should() {
        let result = Gen.zip(
            .from(1...100),
            .from(1...100)
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

    func test_that_a_generator_xctest_succeeds_when_it_should() {
        Gen.zip(
            .from(1...100),
            .from(1...100)
        ).assertForAll { a, b in
            a >= 1 && a <= 100 && b >= 1 && b <= 100
        }
    }

    func test_that_a_generator_xctest_fails_when_it_should() {
        XCTExpectFailure()
        Gen.from(1...100).assertForAll { a in
            a < 1 || a > 100
        }
    }

    func test_check_passed_when_it_should() {
        checkAll(.from(1...100)) { a in
            XCTAssert(a >= 1)
            XCTAssert(a <= 100)
        }
    }

    func test_check_fails_when_it_should() {
        XCTExpectFailure()
        checkAll(.from(1...100)) { a in
            XCTAssert(a < 1)
        }
    }
}
