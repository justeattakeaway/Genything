import Genything
import GenythingTest
import XCTest

internal final class TestAllSatisfyTests: XCTestCase {
    func test_that_testAllSatisfy_succeeds_when_it_should() {
        let gen = Generators.zip(
            (1 ... 100).arbitrary,
            (1 ... 100).arbitrary
        )

        testAllSatisfy(gen) { a, b in
            a >= 1 && a <= 100 &&
                b >= 1 && b <= 100
        }
    }

    func test_that_testAllSatisfy_fails_when_it_should() {
        XCTExpectFailure()
        testAllSatisfy(Generators.constant(false)) { $0 }
    }

    func test_that_testAllSatisfy_runs_the_correct_iteration_amount_from_randomSource() {
        var config = GenythingTestConfig.default()
        config.maxIterations = 999

        let gen = Generators.constant(())

        var count = 0
        testAllSatisfy(gen, config: config) { _ in
            count += 1
            return true
        }

        XCTAssertEqual(config.maxIterations, count)
    }

    func test_that_testAllSatisfy_runs_the_correct_iteration_amount_from_default_randomSource() {
        let config = GenythingTestConfig.default()
        let gen = Generators.constant(())

        var count = 0
        testAllSatisfy(gen) { _ in
            count += 1
            return true
        }

        XCTAssertEqual(config.maxIterations, count)
    }
}
