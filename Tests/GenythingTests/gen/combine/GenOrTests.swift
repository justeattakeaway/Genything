import XCTest
@testable import Genything

final internal class GenOrTests: XCTestCase {
    func test_or_generates_values_from_either() {
        let totalCount = 10000
        let trueCount = Gen
                    .constant(false)
                    .or(.constant(true))
                    .take(count: totalCount)
                    .filter { $0 }
                    .count

        assertAcceptableDelta(total: totalCount, actual: trueCount, acceptablePercentDelta: 0.01)
    }

    func test_or_with_zero_probability() {
        let totalCount = 10000
        let trueCount = Gen
                    .constant(false)
                    .or(.constant(true), otherProbability: 0.0)
                    .take(count: totalCount)
                    .filter { $0 }
                    .count

        XCTAssertEqual(0, trueCount)
    }

    func test_or_with_one_probability() {
        let totalCount = 10000
        let trueCount = Gen
                    .constant(false)
                    .or(.constant(true), otherProbability: 1.0)
                    .take(count: totalCount)
                    .filter { $0 }
                    .count

        XCTAssertEqual(totalCount, trueCount)
    }
}
