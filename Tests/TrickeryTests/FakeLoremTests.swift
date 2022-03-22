import XCTest
@testable import Trickery

class FakeLoremTests: XCTestCase {
    func test_lorem_word() {
        testAll(Fake.Lorem.word){
            XCTAssertFalse($0.isEmpty)
        }
    }

    func test_lorem_sentence() {
        testAll(Fake.Lorem.sentence()) {
            XCTAssertFalse($0.isEmpty)
            XCTAssertEqual(true, $0.first?.isUppercase)
            XCTAssertEqual(".", $0.last)
            XCTAssertTrue($0.dropFirst().allSatisfy {
                $0.isLowercase || !$0.isLetter
            })
        }
    }
}
