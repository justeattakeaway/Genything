import XCTest
import Genything

class Gen_ReplacingOccurencesTests: XCTestCase {
    func test_replacing_occurences_to_create_a_phone_number() {
        let digits = Gen<Int>.from(0...9)
        let gen = digits.replacingOccurrences(of: "#", in: "(###) ###-####")

        gen.forEach { phoneNumber in
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

    func test_replacing_two_occurences_to_create_postal_code() {
        let capitalLetters = Gen<Character>.from("A"..."Z")
        let digits = Gen<Int>.from(0...9)
        let postalCodeFormat = "*#* #*#"

        let gen = digits.replacingOccurrences(of: "#", in: postalCodeFormat)
                    .flatMap { nextFormat in
                        capitalLetters.replacingOccurrences(of: "*", in: nextFormat)
                    }

        gen.forEach { postalCode in
            let subject = Array(postalCode)

            XCTAssertEqual(7, subject.count)

            XCTAssertTrue(subject[0].isLetter)
            XCTAssertTrue(subject[1].isNumber)
            XCTAssertTrue(subject[2].isLetter)

            XCTAssertEqual(" ", subject[3])

            XCTAssertTrue(subject[4].isNumber)
            XCTAssertTrue(subject[5].isLetter)
            XCTAssertTrue(subject[6].isNumber)
        }
    }
}
