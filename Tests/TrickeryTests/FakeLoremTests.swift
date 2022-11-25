import GenythingTest
import XCTest
@testable import Trickery

class FakeLoremTests: XCTestCase {
    func test_lorem_word() {
        TestSuite().testAllSatisfy(Fake.Lorem.word) {
            !$0.isEmpty
        }
    }

    func test_lorem_sentence() {
        TestSuite().testAll(Fake.Lorem.sentence()) { assert, value in
            assert.false(value.isEmpty)
            assert.equal(true, value.first?.isUppercase)
            assert.equal(".", value.last)
            assert(value.dropFirst().allSatisfy {
                $0.isLowercase || !$0.isLetter
            })
        }
    }
}
