import XCTest
@testable import Genything

final internal class Generator_InfiniteSequenceTests: XCTestCase {
    func test_sequence_generates_values() {
        // given a generator of any Integer
        let gen = Int.arbitrary
        // when I turn it into an infinite sequence
        var sequence = gen.asInfiniteSequence()
        // then it generates lots of values
        for _ in 0...1000 {
            XCTAssertNotNil(sequence.next())
        }
        // but I cannot test that it generates infinite values
    }
}
