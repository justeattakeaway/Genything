import XCTest
@testable import Genything

final internal class GenIterateTests: XCTestCase {
    func test_the_sequence_generates_expected_values() {
        var expected = 0
        Gen
            .iterate(0...Int.max)
            .assertForAll {
                defer {
                    expected += 1
                }
                return expected == $0
            }
    }


    func test_exhausted_sequence_generates_nil() {
        let countNonNil = 10
        var i = 0
        Gen
            .iterate(0..<10)
            .assertForAll {
                defer {
                    i += 1
                }
                if i < countNonNil {
                    return $0 != nil
                }
                return $0 == nil
            }
    }

    func test_empty_sequence_generates_nil() {
        Gen
            .iterate([])
            .assertForAll {
                $0 == nil
            }
    }
}
