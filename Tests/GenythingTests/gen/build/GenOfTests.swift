import XCTest
@testable import Genything
import GameKit

final internal class GenOfTests: XCTestCase {
    func test_of_createGenerator() {
        let gen = Gen.of([0, 1, 2])
        let sample = gen.take()

        XCTAssert(sample.contains(0))
        XCTAssert(sample.contains(1))
        XCTAssert(sample.contains(2))
        XCTAssert(sample.allSatisfy { $0 == 0 || $0 == 1 || $0 == 2 })
    }
}
