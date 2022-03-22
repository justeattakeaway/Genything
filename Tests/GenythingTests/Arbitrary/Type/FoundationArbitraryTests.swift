import XCTest
import GenythingTest
@testable import Genything

final internal class FoundationArbitraryTests: XCTestCase {
    func test_dateAbitraryCanGenerateRandomDates() {
        let expectedCount = 100

        var datesSet: Set<Date> = Set()
        for date in Date.arbitrary.asSequence(size: expectedCount) {
            datesSet.insert(date)
        }

        XCTAssertEqual(datesSet.count, expectedCount)
    }
}
