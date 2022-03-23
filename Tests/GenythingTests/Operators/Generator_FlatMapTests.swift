import XCTest
@testable import Genything

final class Generator_FlatMapTests: XCTestCase {
    func test_flatMap_takes_the_same_values() {
        let gen1 = [1, 2, 3].arbitrary
        let gen2 = gen1.flatMap { Generators.constant($0) }
        XCTAssertEqual(gen1.take(1000, randomSource: RandomSource()), gen2.take(1000, randomSource: RandomSource()))
    }
}
