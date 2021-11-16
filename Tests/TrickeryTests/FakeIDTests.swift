import XCTest
@testable import Trickery

class FakeIDTests: XCTestCase {
    func test_length() {
        Fake.ID.uuid.take().forEach {
            XCTAssertTrue($0.uuidString.count == 36)
        }
    }
}
