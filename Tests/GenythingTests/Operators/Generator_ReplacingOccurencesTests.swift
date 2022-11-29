import Genything
import GenythingTest
import XCTest

final class Generator_ReplacingOccurencesTests: XCTestCase {
    func test_replacing_occurences_to_create_a_phone_number() {
        let digits = (0 ... 9).arbitrary
        let gen = digits.replacingOccurrences(of: "#", in: "(###) ###-####")

        testAll(gen) { assert, phoneNumber in
            let subject = Array(phoneNumber)

            assert.equal(14, subject.count)

            assert.equal("(", subject[0])

            assert.true(subject[1].isNumber)
            assert.true(subject[2].isNumber)
            assert.true(subject[3].isNumber)

            assert.equal(")", subject[4])
            assert.equal(" ", subject[5])

            assert.true(subject[6].isNumber)
            assert.true(subject[7].isNumber)
            assert.true(subject[8].isNumber)

            assert.equal("-", subject[9])

            assert.true(subject[10].isNumber)
            assert.true(subject[11].isNumber)
            assert.true(subject[12].isNumber)
            assert.true(subject[13].isNumber)
        }
    }
}
