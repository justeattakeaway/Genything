import XCTest
@testable import Genything

internal final class SwiftArbitraryTests: XCTestCase {
    func test_stringGeneration_createsDifferentStrings_withDifferentSizes() throws {
        let strings = String.arbitrary.take(2, randomSource: .predetermined())

        XCTAssertEqual(2, strings.count)
        XCTAssertNotEqual(strings[0], strings[1])
        XCTAssertNotEqual(strings[0].count, strings[1].count)
    }

    func test_optional_createsOptionals_andRealValues() {
        let arb = (String?).arbitrary
        let samples = arb.take(10, randomSource: .predetermined())

        XCTAssert(samples.contains(nil))

        let nilCount = samples.filter { $0 == nil }.count

        XCTAssert(nilCount != 20 && nilCount != 0)
    }

    func test_boolGeneration_createsRandomBool() {
        let bools = Bool.arbitrary.take(10, randomSource: .predetermined())
        XCTAssertTrue(bools.contains(true))
        XCTAssertTrue(bools.contains(false))
    }
}
