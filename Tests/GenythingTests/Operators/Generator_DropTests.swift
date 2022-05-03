import XCTest
@testable import Genything

final class Generator_DropTests: XCTestCase {
    func test_generator_drop_matches_sequence_behaviour() {
        testAllSatisfy((0...20).arbitrary, (0...20).arbitrary) { dropAmount, takeAmount in
            let sequenced = Array(
                Int.arbitrary
                    .sequence(randomSource: .predetermined())
                    .dropFirst(dropAmount)
                    .prefix(takeAmount)
            )

            let generated = Int.arbitrary.dropFirst(dropAmount).take(takeAmount, randomSource: .predetermined())

            return sequenced == generated
        }
    }
}
