import XCTest
@testable import Trickery

private typealias Numerics = Fake.Numerics

// MARK: - FakeNumericsTests

class FakeNumericsTests: XCTestCase {
    func test_digits() {
        testAll(Numerics.digits) {
            XCTAssertTrue($0 < 10)
            XCTAssertTrue($0 >= 0)
        }
    }
}
