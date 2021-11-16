import XCTest
@testable import Genything

final internal class GenOneOfTests: XCTestCase {
    func test_oneOf() {
        let gen1 = Gen.constant(0)
        let gen2 = Gen.constant(1)

        let iterations = 1000

        // Count which bucket we are taking from
        let count = Gen.one(of: [gen1, gen2]).take(count: iterations).filter { $0 == 0 }.count

        let expectedCount = iterations / 2 // We are expecting exactly half the values to be from bucket 0
        let acceptableDelta = 1 // Allow for 1 integer difference from expectation
        let acceptableRange = (expectedCount-acceptableDelta)...(expectedCount+acceptableDelta)

        XCTAssert(acceptableRange ~= count)
    }
}
