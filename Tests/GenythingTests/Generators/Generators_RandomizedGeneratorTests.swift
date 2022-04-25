import XCTest
@testable import Genything

final class Generators_RandomizedGeneratorTests: XCTestCase {
    func test_a_randomized_generators_take_matches_its_lifted_type() {
        let arb = Int.arbitrary

        XCTAssertEqual(
            arb.take(20, randomSource: .predetermined()),
            arb.randomize(with: .predetermined()).take(20)
        )
    }
}
