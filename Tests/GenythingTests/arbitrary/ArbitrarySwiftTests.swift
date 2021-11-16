import XCTest
@testable import Genything

final internal class ArbitrarySwiftTests: XCTestCase {
    func test_stringGeneration_createsDifferentStrings_withDifferentSizes() throws {
        let strings = String.arbitrary.take(count: 2)

        XCTAssert(strings.count == 2)
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
}
