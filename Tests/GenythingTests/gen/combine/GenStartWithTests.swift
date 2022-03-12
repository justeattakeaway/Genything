import XCTest
@testable import Genything

final internal class GenStartWithTests: XCTestCase {
    func test_after_the_sequence_concludes_we_switch_to_the_receiver() {
        var expected = 1
        Gen.constant(Int.max)
            .asStatefulGen()
            .startWith(1...10)
            .start()
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
        Gen.constant(0)
            .asStatefulGen()
            .startWith(1...Int.max)
            .start()
            .assertForAll {
                defer {
                    expected += 1
                }
                return expected == $0
            }
    }
}
