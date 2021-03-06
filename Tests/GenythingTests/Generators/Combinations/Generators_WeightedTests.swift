import GenythingTest
import XCTest
@testable import Genything

final class Generators_WeightedTests: XCTestCase {
    func test_weighted_with_equal_weights() {
        let values = Generators.weighted([
            (1, "A"),
            (1, "B"),
        ]).sequence(1000, randomSource: .predetermined()).countDistinct()

        guard
            let a = values["A"],
            let b = values["B"]
        else {
            return XCTFail()
        }

        XCTAssertEqual(a, b, accuracy: 5)
    }

    func test_weighted_with_uneven_weights() {
        let values = Generators.weighted([
            (2, "A"),
            (1, "B"),
        ]).sequence(1000, randomSource: .predetermined()).countDistinct()

        guard
            let a = values["A"],
            let b = values["B"]
        else {
            return XCTFail()
        }

        XCTAssertEqual(a - b, b, accuracy: 50)
    }
}
