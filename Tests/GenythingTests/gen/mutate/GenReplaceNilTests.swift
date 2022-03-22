import XCTest
@testable import Genything

final internal class GenReplaceNilTests: XCTestCase {
    func test_givenRandomNils_allAreReplaced() {
        let gen = Generators.constant(true)
            .orNil()
            .replaceNil(with: true)

        testAllSatisfy(gen) { $0 }
    }

    func test_givenIteratorNils_allAreReplaced() {
        let range = (0...5)

        let gen = Exhaustive
            .Iterate(range)
            .replaceNil(with: 0)

        testAllSatisfy(gen) {
            range.contains($0)
        }
    }
}
