import XCTest
@testable import Genything

final class ExhaustiveLoopTests: XCTestCase {
    func test_a_long_sequence_never_loops_but_generates_expected_values() {
        var expected = 0
        testAllSatisfy(DeferredGenerators.loop(0 ... Int.max).start()) {
            defer {
                expected += 1
            }
            return expected == $0
        }
    }

    func test_a_short_sequence_loops_with_expected_values() {
        var expected = 0
        testAllSatisfy(DeferredGenerators.loop(0 ... 10).start()) {
            defer {
                if expected == 10 {
                    expected = 0
                } else {
                    expected += 1
                }
            }
            return expected == $0
        }
    }

    func test_that_i_can_loop_a_list() {
        var expected = false
        testAllSatisfy(DeferredGenerators.loop([false, true]).start()) {
            defer { expected = !expected }
            return $0 == expected
        }
    }
}
