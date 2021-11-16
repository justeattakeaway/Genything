import XCTest
@testable import Genything

final internal class GenFromRangeTests: XCTestCase {
    func test_fromElements_createsGenerator_usingIntegers() {
        let gen = Gen.from(0...1)
        let sample = gen.take()

        XCTAssert(sample.contains(0))
        XCTAssert(sample.contains(1))
        XCTAssert(sample.allSatisfy { $0 == 0 || $0 == 1 })
    }

    func test_fromElements_createsGenerator_usingIntegers_halfOpen_lessThan() {
        let gen = Gen.from(0..<1)
        let sample = gen.take()

        XCTAssert(sample.contains(0))
        XCTAssert(sample.allSatisfy { $0 == 0 })
    }

    func test_fromElements_createsGenerator_usingStrings() {
        let gen = Gen<Character>.from("a"..."z")
        let samples = gen.samples()

        XCTAssert(samples.allSatisfy { $0.isLowercase })
    }
}
