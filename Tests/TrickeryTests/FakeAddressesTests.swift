import GenythingTest
import XCTest
@testable import Trickery

class FakeAddressesTests: XCTestCase {
    func test_streetNumber() {
        testAll(Fake.Addresses.streetNumber) { _, streetNumber in
            XCTAssert(streetNumber.count <= 4)
            streetNumber.forEach { XCTAssertTrue($0.isNumber) }
        }
    }

    func test_steetName() {
        testAll(Fake.Addresses.streetName) { _, streetName in
            XCTAssert(streetName.count > 2)
            streetName.forEach { XCTAssertFalse($0.isNumber) }
        }
    }

    func test_usCity() {
        testAll(Fake.Addresses.usCity) { _, city in
            XCTAssert(city.count > 2)
            city.forEach { XCTAssertFalse($0.isNumber) }
        }
    }

    func test_caCity() {
        testAll(Fake.Addresses.caCity) { _, city in
            XCTAssert(city.count > 2)
            city.forEach { XCTAssertFalse($0.isNumber) }
        }
    }

    func test_stateCode() {
        testAll(Fake.Addresses.stateCode) { _, stateCode in
            XCTAssertEqual(stateCode.count, 2)
            stateCode.forEach { XCTAssertTrue($0.isLetter) }
        }
    }

    func test_state() {
        testAll(Fake.Addresses.state) { _, state in
            XCTAssert(state.count > 2)
            state.forEach { XCTAssertFalse($0.isNumber) }
        }
    }

    func test_provinceCode() {
        testAll(Fake.Addresses.provinceCode) { _, provinceCode in
            XCTAssertEqual(provinceCode.count, 2)
            provinceCode.forEach { XCTAssertTrue($0.isLetter) }
        }
    }

    func test_province() {
        testAll(Fake.Addresses.province) { _, province in
            XCTAssert(province.count > 2)
            province.forEach { XCTAssertFalse($0.isNumber) }
        }
    }

    func test_countryCode() {
        testAll(Fake.Addresses.countryCode) { _, countryCode in
            XCTAssertEqual(countryCode.count, 2)
            countryCode.forEach { XCTAssertTrue($0.isLetter) }
        }
    }

    func test_country() {
        testAll(Fake.Addresses.country) { _, country in
            XCTAssert(country.count > 2)
            country.forEach { XCTAssertFalse($0.isNumber) }
        }
    }

    func test_postalCode() {
        testAll(Fake.Addresses.postalCode) { _, postalCode in
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
        testAll(Fake.Addresses.zipCode) { _, zipCode in
            XCTAssertEqual(zipCode.count, 5)
            zipCode.forEach { XCTAssertTrue($0.isNumber) }
        }
    }

    func test_usLastLine() {
        testAll(Fake.Addresses.usLastLine) { _, usLastLine in
            let parts = usLastLine.components(separatedBy: ",")
            XCTAssertEqual(parts.count, 2)
        }
    }

    func test_caLastLine() {
        testAll(Fake.Addresses.caLastLine) { _, caLastLine in
            let parts = caLastLine.components(separatedBy: " ")
            XCTAssert(parts.count >= 2)
        }
    }

    func test_unitedStates() {
        testAll(Fake.Addresses.unitedStates) { _, unitedStates in
            let parts = unitedStates.components(separatedBy: "\n")
            XCTAssertEqual(parts.count, 2)
        }
    }

    func test_canada() {
        testAll(Fake.Addresses.canada) { _, canada in
            let parts = canada.components(separatedBy: "\n")
            XCTAssertEqual(parts.count, 2)
        }
    }
}
