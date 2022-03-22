import XCTest
@testable import Trickery

class FakeCharactersTests: XCTestCase {
    func test_lowercase() {
        testAll(Fake.Characters.lowercase) {
            XCTAssertTrue($0.isLowercase)
        }
    }

    func test_uppercase() {
        testAll(Fake.Characters.uppercase) {
            XCTAssertTrue($0.isUppercase)
        }
    }

    func test_alphanumeric() {
        testAll(Fake.Characters.alphanumeric) {
            XCTAssertTrue($0.isNumber || $0.isLetter)
        }
    }
}
