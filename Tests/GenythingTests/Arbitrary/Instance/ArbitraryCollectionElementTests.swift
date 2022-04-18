import GenythingTest
import XCTest
@testable import Genything

internal final class ArbitraryCollectionElementTests: XCTestCase {
    func test_creating_a_generator_of_arbitrary_elements() {
        // Given a sequence of arbitrary elements
        let sequence = [0, 1, 2].arbitrary.sequence(100, randomSource: RandomSource())

        // The sequence should have probably generated every possibility
        XCTAssert(sequence.contains(0))
        XCTAssert(sequence.contains(1))
        XCTAssert(sequence.contains(2))

        // And the sequence contains no other possibilities
        XCTAssert(sequence.allSatisfy { $0 == 0 || $0 == 1 || $0 == 2 })
    }
}
