import GenythingTest
import XCTest
@testable import Trickery

class FakePhoneNumberTests: XCTestCase {
    func test_phoneNumber() {
        TestSuite().testAll(Fake.PhoneNumbers.formatted) { assert, phoneNumber in
            let subject = Array(phoneNumber)

            assert.equal(14, subject.count)

            assert.equal("(", subject[0])

            assert(subject[1].isNumber)
            assert(subject[2].isNumber)
            assert(subject[3].isNumber)

            assert.equal(")", subject[4])
            assert.equal(" ", subject[5])

            assert(subject[6].isNumber)
            assert(subject[7].isNumber)
            assert(subject[8].isNumber)

            assert.equal("-", subject[9])

            assert(subject[10].isNumber)
            assert(subject[11].isNumber)
            assert(subject[12].isNumber)
            assert(subject[13].isNumber)
        }
    }
}
