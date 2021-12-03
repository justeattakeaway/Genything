import XCTest
import Genything
import GenythingTest

final internal class GenAssertForAllTests: XCTestCase {
    func test_that_assertForAll_succeeds_when_it_should() {
        Gen.zip(
            .from(1...100),
            .from(1...100)
        ).assertForAll { a, b in
            a >= 1 && a <= 100 &&
            b >= 1 && b <= 100
        }
    }

    func test_that_assertForAll_fails_when_it_should() {
        XCTExpectFailure()
        Gen.from(1...100).assertForAll { a in
            a < 1 || a > 100
        }
    }

    func test_that_assertForAll_runs_the_correct_iteration_amount_from_parameter() {
        let iterations = 999

        var count = 0
        Gen.constant(()).assertForAll(iterations: iterations) { _ in
            count += 1
            return true
        }

        XCTAssertEqual(iterations, count)
    }

    func test_that_assertForAll_runs_the_correct_iteration_amount_from_context() {
        let context = Context.default
        context.maxIterations = 999

        var count = 0
        Gen.constant(()).assertForAll(context: context) { _ in
            count += 1
            return true
        }

        XCTAssertEqual(context.maxIterations, count)
    }
}
