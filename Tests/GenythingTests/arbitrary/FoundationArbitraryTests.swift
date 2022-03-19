import XCTest
@testable import Genything

final internal class FoundationArbitraryGeneratableTests: XCTestCase {
    // MARK: - Constants

    let arbitraryCount = 100

    // MARK: - Tests

    func test_dateAbitraryCanGenerateRandomDates() {
        var datesSet: Set<Date> = Set()
        Date.arbitrary.take(arbitraryCount).forEach {
            datesSet.insert($0)
        }
        XCTAssertEqual(datesSet.count, arbitraryCount)
    }
}
