import GenythingTest
import XCTest
@testable import Genything

internal final class FoundationArbitraryTests: XCTestCase {
    func test_dateAbitraryCanGenerateRandomDates() {
        let expectedCount = 100

        var datesSet: Set<Date> = Set()
        for date in Date.arbitrary.sequence(expectedCount, randomSource: RandomSource()) {
            datesSet.insert(date)
        }

        XCTAssertEqual(datesSet.count, expectedCount)
    }
}
