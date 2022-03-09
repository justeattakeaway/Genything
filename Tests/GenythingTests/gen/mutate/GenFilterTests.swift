import XCTest
import Genything
import GenythingTest

class Gen_FilterTests: XCTestCase {
    func test_filtering_where_it_is_obviously_not_possible() {
        XCTAssertThrowsError(
            /// `false` will never be `true` and filter will reach max depth
            try Gen.constant(false)
                .filter { $0 == true }
                .safe.take()
        )
    }

    func test_filtering_where_it_is_not_reasonable() {
        XCTAssertThrowsError(
            /// There is a 1 in ~4 billion chance of generating an `Int == 0`
            /// Without `maxDepth` this test would run at 100% cpu for many minutes before generating even **one** value
            try Int.arbitrary
                .filter { $0 == 999 }
                .safe.take()
        )
    }

    func test_filtering_where_it_is_possible() {
        func check(_ value: Int) -> Bool {
            value == 0
        }

        Gen.looping([0, 1])
            .filter { check($0) }
            .assertForAll {
                check($0)
            }
    }
}
