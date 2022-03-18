import XCTest
@testable import Trickery

class FakeIDTests: XCTestCase {
    func test_length() {
        checkAll(Fake.ID.uuid) {
            XCTAssertTrue($0.uuidString.count == 36)
        }
    }
}
