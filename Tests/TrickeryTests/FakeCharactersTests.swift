import XCTest
@testable import Trickery

class FakeCharactersTests: XCTestCase {
    func test_lowercase() {
        checkAll(Fake.Characters.lowercase) {
            XCTAssertTrue($0.isLowercase)
        }
    }

    func test_uppercase() {
        checkAll(Fake.Characters.uppercase) {
            XCTAssertTrue($0.isUppercase)
        }
    }

    func test_alphanumeric() {
        checkAll(Fake.Characters.alphanumeric) {
            XCTAssertTrue($0.isNumber || $0.isLetter)
        }
    }
}
