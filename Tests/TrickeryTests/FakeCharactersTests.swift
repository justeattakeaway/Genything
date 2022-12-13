import GenythingTest
import XCTest
@testable import Trickery

class FakeCharactersTests: XCTestCase {
    func test_lowercase() {
        testAllSatisfy(Fake.Characters.lowercase) {
            $0.isLowercase
        }
    }

    func test_uppercase() {
        testAllSatisfy(Fake.Characters.uppercase) {
            $0.isUppercase
        }
    }

    func test_alphanumeric() {
        testAllSatisfy(Fake.Characters.alphanumeric) {
            $0.isNumber || $0.isLetter
        }
    }
}
