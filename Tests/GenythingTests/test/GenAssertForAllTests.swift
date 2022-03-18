import XCTest
import Genything
import GenythingTest

final internal class GenAssertForAllTests: XCTestCase {
    func test_that_assertForAll_succeeds_when_it_should() {
        Generators.zip(
            Generators.from(1...100),
            Generators.from(1...100)
        ).assertForAll { a, b in
            a >= 1 && a <= 100 &&
            b >= 1 && b <= 100
        }
    }

    func test_that_assertForAll_fails_when_it_should() {
        XCTExpectFailure()
        Generators.from(1...100).assertForAll { a in
            a < 1 || a > 100
        }
    }

    func test_that_assertForAll_runs_the_correct_iteration_amount_from_parameter() {
        let iterations = 999

        var count = 0
        Generators.Constant(()).assertForAll(iterations: iterations) { _ in
            count += 1
            return true
        }

        XCTAssertEqual(iterations, count)
    }

    func test_that_assertForAll_runs_the_correct_iteration_amount_from_context() {
        var count = 0
        Generators.Constant(()).assertForAll() { _ in
            count += 1
            return true
        }

        XCTAssertEqual(TestConfig.maxIterations, count)
    }
}
