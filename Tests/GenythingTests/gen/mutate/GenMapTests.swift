import XCTest
@testable import Genything

final internal class GenMapTests: XCTestCase {
    func test_map() {
        let gen1 = Gen.of([1, 2, 3])
        let gen2 = gen1.map { $0 }
        XCTAssertEqual(gen1.take(), gen2.take())
    }
}
