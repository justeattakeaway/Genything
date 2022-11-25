import GenythingTest
import XCTest
@testable import Trickery

class FakeIDTests: XCTestCase {
    func test_length() {
        TestSuite().testAllSatisfy(Fake.ID.uuid) {
            $0.uuidString.count == 36
        }
    }
}
