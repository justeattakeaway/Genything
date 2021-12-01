import XCTest
@testable import Genything

final internal class GenFlatMapTests: XCTestCase {
    func test_flatMap_takes_the_same_values() {
        let gen1 = Gen.of([1, 2, 3])
        let gen2 = gen1.flatMap { Gen.constant($0) }
        XCTAssertEqual(gen1.take(), gen2.take())
    }
}
