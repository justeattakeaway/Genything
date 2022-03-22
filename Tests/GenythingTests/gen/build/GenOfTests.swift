import XCTest
@testable import Genything
import GenythingTest

final internal class GenOfTests: XCTestCase {
    func test_of_createGenerator() {
        let gen = [0, 1, 2].arbitrary
        let sample = gen.take(1000)

        XCTAssert(sample.contains(0))
        XCTAssert(sample.contains(1))
        XCTAssert(sample.contains(2))
        XCTAssert(sample.allSatisfy { $0 == 0 || $0 == 1 || $0 == 2 })
    }
}
