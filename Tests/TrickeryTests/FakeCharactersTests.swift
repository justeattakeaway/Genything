import XCTest
@testable import Trickery

class FakeCharactersTests: XCTestCase {
    func test_lowercase() {
        Fake.Characters.lowercase.take().forEach {
            XCTAssertTrue($0.isLowercase)
        }
    }

    func test_uppercase() {
        Fake.Characters.uppercase.take().forEach {
            XCTAssertTrue($0.isUppercase)
        }
    }

    func test_alphanumeric() {
        Fake.Characters.alphanumeric.take().forEach {
            XCTAssertTrue($0.isNumber || $0.isLetter)
        }
    }
}
