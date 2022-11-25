import GenythingTest
import XCTest
@testable import Trickery

class FakeNamesTests: XCTestCase {
    func test_names_full() {
        TestSuite().testAll(Fake.PersonNames.full()) { assert, value in
            let names = value.components(separatedBy: .whitespaces)
            names.forEach {
                assert.equal(true, $0.first?.isUppercase)
            }
        }
    }

    func test_names_full_number_of_words() {
        TestSuite().testAllSatisfy(Fake.PersonNames.full()) {
            // Some names like "Jo Ann" can have 2 words
            let numberOfWords = $0.components(separatedBy: .whitespaces).count

            return numberOfWords >= 2 && numberOfWords <= 5
        }
    }
}
