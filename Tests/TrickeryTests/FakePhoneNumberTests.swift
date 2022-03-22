import XCTest
import GenythingTest
@testable import Trickery

class FakePhoneNumberTests: XCTestCase {
    func test_phoneNumber() {
        testAll(Fake.PhoneNumbers.formatted) { phoneNumber in
            let subject = Array(phoneNumber)

            XCTAssertEqual(14, subject.count)

            XCTAssertEqual("(", subject[0])

            XCTAssertTrue(subject[1].isNumber)
            XCTAssertTrue(subject[2].isNumber)
            XCTAssertTrue(subject[3].isNumber)

            XCTAssertEqual(")", subject[4])
            XCTAssertEqual(" ", subject[5])

            XCTAssertTrue(subject[6].isNumber)
            XCTAssertTrue(subject[7].isNumber)
            XCTAssertTrue(subject[8].isNumber)

            XCTAssertEqual("-", subject[9])

            XCTAssertTrue(subject[10].isNumber)
            XCTAssertTrue(subject[11].isNumber)
            XCTAssertTrue(subject[12].isNumber)
            XCTAssertTrue(subject[13].isNumber)
        }
    }
}
