import XCTest
@testable import Trickery

private typealias Numerics = Fake.Numerics

class FakeNumericsTests: XCTestCase {
    func test_digits() {
        checkAll(Numerics.digits) {
            XCTAssertTrue($0 < 10)
            XCTAssertTrue($0 >= 0)
        }
    }
}
