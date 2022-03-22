import XCTest
@testable import Genything

internal final class ExhaustiveIterateTests: XCTestCase {
    func test_the_sequence_generates_expected_values() {
        var expected = 0
        testAllSatisfy(Exhaustive.Iterate(0 ... Int.max)) {
            defer { expected += 1 }
            return expected == $0
        }
    }

    func test_exhausted_sequence_generates_nil() {
        let countNonNil = 10
        var i = 0
        testAllSatisfy(Exhaustive.Iterate(0 ..< 10)) {
            defer { i += 1 }
            if i < countNonNil {
                return $0 != nil
            }
            return $0 == nil
        }
    }

    func test_empty_sequence_generates_nil() {
        testAllSatisfy(Exhaustive.Iterate([])) {
            $0 == nil
        }
    }
}
