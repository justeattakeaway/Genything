import GenythingTest
import XCTest
@testable import Trickery

private typealias Numerics = Fake.Numerics

// MARK: - FakeNumericsTests

class FakeNumericsTests: XCTestCase {
    func test_digits() {
        TestSuite().testAll(Numerics.digits) { assert, val in
            assert(val < 10)
            assert(val >= 0)
        }
    }
}
