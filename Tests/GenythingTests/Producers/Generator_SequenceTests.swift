import XCTest
@testable import Genything

internal final class Generator_SequenceTests: XCTestCase {
    func test_sequence_is_finite() {
        // given a generator of any Integer
        let gen = Int.arbitrary

        // when I run a loop of size `100`
        for _ in gen.sequence(100, randomSource: .predetermined()) {
            // no-op
        }

        // i exit the test gracefully
    }

    func test_sequence_is_the_correct_length() {
        // given a generator of any Integer
        let gen = Int.arbitrary
        // an expected size
        let expected = 100
        // and a counter
        var count = 0
        // when I run a loop and count
        for _ in gen.sequence(expected, randomSource: .predetermined()) {
            count += 1
        }
        // then count matches expectations
        XCTAssertEqual(count, expected)
    }

    func test_empty_sequence_is_the_correct_length() {
        // given a generator of any Integer
        let gen = Int.arbitrary
        // an expected size
        let expected = 0
        // and a counter
        var count = 0
        // when I run a loop and count
        for _ in gen.sequence(0, randomSource: .predetermined()) {
            count += 1
        }
        // then count matches expectations
        XCTAssertEqual(count, expected)
    }
}
