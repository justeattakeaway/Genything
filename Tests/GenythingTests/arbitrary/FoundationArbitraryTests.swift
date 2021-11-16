import XCTest
@testable import Genything

final internal class FoundationArbitraryTests: XCTestCase {
    // MARK: - Constants

    let arbitraryCount = 100

    // MARK: - Tests

    func test_dateAbitraryCanGenerateRandomDates() {
        var datesSet: Set<Date> = Set()
        Date.arbitrary.take(count: arbitraryCount).forEach {
            datesSet.insert($0)
        }
        XCTAssertEqual(datesSet.count, arbitraryCount)
    }

    //    func test_complexUrlString() {
    //        _ = URL.arbitrary.sample() // Checking for fatalError
    //    }
    //
    //    func test_forAll() {
    //        let count = 100
    //
    //        var i = 0
    //        URL.arbitrary.take(count: count).forEach {
    //            XCTAssert(!$0.isFileURL)
    //            i += 1
    //        }
    //
    //        XCTAssertEqual(i, count)
    //    }
}
