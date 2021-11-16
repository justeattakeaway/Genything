import XCTest
@testable import Genything

final internal class GenFromRangeTests: XCTestCase {
    func test_fromElements_usingClosedRangeOf_Integers_IncludesAllElements() {
        let gen = Gen.from(0...1)
        let sample = gen.take()

        XCTAssert(sample.contains(0))
        XCTAssert(sample.contains(1))
        XCTAssert(sample.allSatisfy { $0 == 0 || $0 == 1 })
    }

    func test_fromElements_usingRangeOf_Integers_DoesNotIncludeLastElement() {
        let gen = Gen.from(0..<1)
        let sample = gen.take()

        XCTAssert(sample.contains(0))
        XCTAssert(sample.allSatisfy { $0 == 0 })
    }

    func test_fromElements_usingClosedRangeOf_Characters_IncludesAllElements() {
        let gen = Gen<Character>.from("a"..."z")
        let samples = gen.take()

        XCTAssert(samples.allSatisfy { $0.isLowercase })
        XCTAssertTrue(samples.contains("z"))
    }

    func test_fromElements_usingRangeOf_Characters_DoesNotIncludeLastElement() {
        let gen = Gen<Character>.from("a"..<"z")
        let samples = gen.take()

        XCTAssert(samples.allSatisfy { $0.isLowercase })
        XCTAssertFalse(samples.contains("z"))
    }
}
