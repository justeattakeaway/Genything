import XCTest
@testable import Genything

final class Generators_OneOfTests: XCTestCase {
    func test_oneOf_generates_equally() {
        let gen0 = Generators.constant(0)
        let gen1 = Generators.constant(1)

        let iterations = 10000

        // Count which bucket we are taking from
        let countGen0 = Generators
            .one(of: [gen0, gen1])
            .take(iterations, randomSource: RandomSource())
            .filter { $0 == 0 }
            .count

        XCTAssertEqual(countGen0, iterations / 2, accuracy: Int(Double(iterations) * 0.01))
    }
}
