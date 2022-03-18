import XCTest
import Genything
import GenythingTest

class Gen_AlsoTests: XCTestCase {
    func test_also_runs_side_effect_once_per_generation() {
        let iterations = 100

        var count = 0
        _ = Generators.Constant(()).also {
            count += 1
        }.take(iterations)

        XCTAssertEqual(iterations, count)
    }
}
