import XCTest
@testable import Trickery

class FakeNamesTests: XCTestCase {
    func test_names_full() {
        checkAll(Fake.PersonNames.full) {
            let names = $0.components(separatedBy: .whitespaces)
            names.forEach {
                XCTAssertEqual(true, $0.first?.isUppercase)
            }
        }
    }
    
    func test_names_full_number_of_words() {
        checkAll(Fake.PersonNames.full) {
            // Some names like "Jo Ann" can have 2 words
            let numberOfWords = $0.components(separatedBy: .whitespaces).count
            XCTAssertTrue( numberOfWords >= 2 && numberOfWords <= 4 )
        }
    }
}
