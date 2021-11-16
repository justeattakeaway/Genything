import XCTest
@testable import Genything

final internal class GenOneOfTests: XCTestCase {
    func test_oneOf() {
        let gen1 = Gen.constant(0)
        let gen2 = Gen.constant(1)

        let gen1CountProductionCount = Gen.one(of: [gen1, gen2]).take().filter { $0 == 0 }.count

        XCTAssert(gen1CountProductionCount < 75 && gen1CountProductionCount > 25)
    }
}
