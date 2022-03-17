import XCTest
@testable import Genything

final internal class GenReplaceNilTests: XCTestCase {
    func test_givenRandomNils_allAreReplaced() {
        Gen
            .constant(true)
            .orNil()
            .replaceNil(with: true)
            .assertForAll {
                $0
            }
    }

    func test_givenIteratorNils_allAreReplaced() {
        let range = (0...5)

        Gen
            .iterate(range)
            .replaceNil(with: 0)
            .assertForAll {
                range.contains($0)
            }
    }
}
