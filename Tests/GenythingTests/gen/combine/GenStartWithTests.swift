import XCTest
@testable import Genything

final internal class GenStartWithTests: XCTestCase {
    func test_after_the_sequence_concludes_we_switch_to_the_receiver() {
        var expected = 1
        Generators.Constant(Int.max)
            .startWith(1...10)
            .assertForAll {
                defer {
                    if expected < 10 {
                        expected += 1
                    } else {
                        expected = Int.max
                    }
                }
                return expected == $0
            }
    }

    func test_a_long_enough_sequence_never_switches_to_the_receiver_gen() {
        var expected = 1
        Generators.Constant(0)
            .startWith(1...Int.max)
            .assertForAll {
                defer {
                    expected += 1
                }
                return expected == $0
            }
    }
}
