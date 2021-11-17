import XCTest
@testable import Trickery

class FakeAddressesTests: XCTestCase {
    func test_streetNumber() {
        Fake.Addresses.streetNumber.forEach { streetNumber in
            XCTAssert(streetNumber.count <= 4)
            streetNumber.forEach { XCTAssertTrue($0.isNumber) }
        }
    }

    func test_steetName() {
        Fake.Addresses.streetName.forEach { streetName in
            XCTAssert(streetName.count > 2)
            streetName.forEach { XCTAssertFalse($0.isNumber) }
        }
    }

    func test_usCity() {
        Fake.Addresses.usCity.forEach { city in
            XCTAssert(city.count > 2)
            city.forEach { XCTAssertFalse($0.isNumber) }
        }
    }

    func test_caCity() {
        Fake.Addresses.caCity.forEach { city in
            XCTAssert(city.count > 2)
            city.forEach { XCTAssertFalse($0.isNumber) }
        }
    }

    func test_stateCode() {
        Fake.Addresses.stateCode.forEach { stateCode in
            XCTAssertEqual(stateCode.count, 2)
            stateCode.forEach { XCTAssertTrue($0.isLetter) }
        }
    }

    func test_state() {
        Fake.Addresses.state.forEach { state in
            XCTAssert(state.count > 2)
            state.forEach { XCTAssertFalse($0.isNumber) }
        }
    }

    func test_provinceCode() {
        Fake.Addresses.provinceCode.forEach { provinceCode in
            XCTAssertEqual(provinceCode.count, 2)
            provinceCode.forEach { XCTAssertTrue($0.isLetter) }
        }
    }

    func test_province() {
        Fake.Addresses.province.forEach { province in
            XCTAssert(province.count > 2)
            province.forEach { XCTAssertFalse($0.isNumber) }
        }
    }

    func test_countryCode() {
        Fake.Addresses.countryCode.forEach { countryCode in
            XCTAssertEqual(countryCode.count, 2)
            countryCode.forEach { XCTAssertTrue($0.isLetter) }
        }
    }

    func test_country() {
        Fake.Addresses.country.forEach { country in
            XCTAssert(country.count > 2)
            country.forEach { XCTAssertFalse($0.isNumber) }
        }
    }

    func test_postalCode() {
        Fake.Addresses.postalCode.forEach { postalCode in
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

    func test_zipCode() {
        Fake.Addresses.zipCode.forEach { zipCode in
            XCTAssertEqual(zipCode.count, 5)
            zipCode.forEach { XCTAssertTrue($0.isNumber) }
        }
    }

    func test_usLastLine() {
        Fake.Addresses.usLastLine.forEach { usLastLine in
            let parts = usLastLine.components(separatedBy: ",")
            XCTAssertEqual(parts.count, 2)
        }
    }

    func test_caLastLine() {
        Fake.Addresses.caLastLine.forEach { caLastLine in
            let parts = caLastLine.components(separatedBy: " ")
            XCTAssert(parts.count >= 2)
        }
    }

    func test_unitedStates() {
        Fake.Addresses.unitedStates.forEach { unitedStates in
            let parts = unitedStates.components(separatedBy: "\n")
            XCTAssertEqual(parts.count, 2)
        }
    }

    func test_canada() {
        Fake.Addresses.canada.forEach { canada in
            let parts = canada.components(separatedBy: "\n")
            XCTAssertEqual(parts.count, 2)
        }
    }

    func test_test() {
        Fake.Emails.personal.forEach { email in
            print(email)
        }

        Fake.Emails.business.forEach { email in
            print(email)
        }
    }
}
