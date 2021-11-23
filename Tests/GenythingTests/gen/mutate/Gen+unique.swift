import XCTest
import Genything

class Gen_UniqueTests: XCTestCase {
    func test_uniquing_where_it_is_possible() {
        let values = Gen.from(1...10).unique().take(count: 10)

        XCTAssertEqual(
            [1,2,3,4,5,6,7,8,9,10],
            values.sorted()
        )
    }

    func test_uniquing_where_it_is_not_possible() {
        XCTExpectFailure("Generating 100 unique values from a pool of 10 possibilities cannot be done")
        _ = Gen.from(1...10).unique().take(count: 100)
    }
}
