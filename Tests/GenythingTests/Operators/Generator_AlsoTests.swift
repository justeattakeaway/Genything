import Genything
import GenythingTest
import XCTest

final class Generator_AlsoTests: XCTestCase {
    func test_also_runs_side_effect_once_per_generation() {
        let iterations = 100

        var count = 0
        _ = Generators.constant(()).also {
            count += 1
        }.take(iterations, randomSource: RandomSource())

        XCTAssertEqual(iterations, count)
    }
}
