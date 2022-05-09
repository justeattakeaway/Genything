import XCTest
@testable import Genything

final class Generator_FlattenTests: XCTestCase {
    func test_flatten_undoes_expand() {
        let gen = Int.arbitrary

        let flattenedGen = gen // Generator<Int>
            .expand(toSize: 10) // Generator<[Int]>
            .flatten() // Generator<Int>

        XCTAssertEqual(
            gen.take(1000, randomSource: .predetermined()),
            flattenedGen.take(1000, randomSource: .predetermined())
        )
    }
}
