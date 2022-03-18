import XCTest
@testable import Genything

final internal class GenLoopingTests: XCTestCase {
    func test_a_long_sequence_never_loops_but_generates_expected_values() {
        var expected = 0
        Generators
            .ShuffleLoop(collection: 0...Int.max, context: .default)
            .assertForAll(iterations: 1000) {
                defer {
                    expected += 1
                }
                return expected == $0
            }
    }

    func test_a_short_sequence_loops_with_expected_values() {
        var expected = 0
        Generators
            .ShuffleLoop(collection: 0...10, context: .default)
            .assertForAll(iterations: 1000) {
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
        Generators
            .ShuffleLoop(collection: [false, true], context: .default)
            .assertForAll {
                defer { expected = !expected }
                return $0 == expected
            }
    }
}
