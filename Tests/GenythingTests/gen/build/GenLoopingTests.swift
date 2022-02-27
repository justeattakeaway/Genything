import XCTest
@testable import Genything

final internal class GenLoopingTests: XCTestCase {
    func test_a_long_sequence_never_loops_but_generates_expected_values() {
        var expected = 0
        Gen
            .looping(0...Int.max)
            .assertForAll(iterations: 1000) {
                defer {
                    expected += 1
                }
                return expected == $0
            }
    }

    func test_a_short_sequence_loops_with_expected_values() {
        var expected = 0
        Gen
            .looping(0...10)
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
//
//    func test_a_short_gen_sequence_loops_with_expected_values() {
//        var expected = 0
//        Gen
//            .looping([.constant(0), .constant(1), .constant(2)])
//            .assertForAll(iterations: 1000) {
//                defer {
//                    if expected == 2 {
//                        expected = 0
//                    } else {
//                        expected += 1
//                    }
//                }
//                return expected == $0
//            }
//    }
}
