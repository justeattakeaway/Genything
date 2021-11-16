import XCTest
@testable import Genything

final internal class SwiftArbitraryTests: XCTestCase {
    func test_stringGeneration_createsDifferentStrings_withDifferentSizes() throws {
        let strings = String.arbitrary.take(count: 2)

        XCTAssertEqual(2, strings.count)
        XCTAssertNotEqual(strings[0], strings[1])
        XCTAssertNotEqual(strings[0].count, strings[1].count)
    }

    func test_optional_createsOptionals_andRealValues() {
        let arb = (String?).arbitrary
        let samples = arb.samples()

        XCTAssert(samples.contains(nil))

        let nilCount = samples.filter { $0 == nil }.count

        XCTAssert(nilCount != 20 && nilCount != 0)
    }

    func test_boolGeneration_createsRandomBool() {
        let bools = Bool.arbitrary.take()
        XCTAssertTrue(bools.contains(true))
        XCTAssertTrue(bools.contains(false))
    }
}
