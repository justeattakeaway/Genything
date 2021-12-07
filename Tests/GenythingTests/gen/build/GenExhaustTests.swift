import XCTest
import Genything
import GenythingTest

final internal class GenExhaustTests: XCTestCase {
    func test_the_exhaustion_of_values() {
        let gen = Gen.exhaust([0, 1, 2], then: .from(3...10))

        gen.assertForAll { 0...10 ~= $0 }

        let count = 100
        let values = gen.take(count: count)

        XCTAssertEqual(0, values[0])
        XCTAssertEqual(1, values[1])
        XCTAssertEqual(2, values[2])

        for i in 3..<count {
            XCTAssertTrue(3...10 ~= values[i])
        }
    }

    func test_n_exhaustives_1_context() {
        let other = Gen.from(3...10)
        let gen1 = Gen.exhaust([0, 1, 2], then: other)
        let gen2 = Gen.exhaust([0, 1, 2], then: other)

        let count = 100
        let values = gen1.zip(with: gen2).take(count: count)

        XCTAssertEqual(0, values[0].0)
        XCTAssertEqual(0, values[0].1)

        XCTAssertEqual(1, values[1].0)
        XCTAssertEqual(1, values[1].1)

        XCTAssertEqual(2, values[2].0)
        XCTAssertEqual(2, values[2].1)

        for i in 3..<count {
            XCTAssertTrue(3...10 ~= values[i].0)
            XCTAssertTrue(3...10 ~= values[i].1)
        }
    }
}
