import XCTest
@testable import Genything

final internal class GenProliferateTests: XCTestCase {
    func test_proliferate_withSize_createsWithCorrectSize() {
        let size = 10
        let strings = String.arbitrary
            .proliferate(withSize: size)
            .take()

        XCTAssert(strings.allSatisfy { s in
            s.count == size
        })
    }

    func test_proliferate_inRange_createsInsideCorrectBounds() {
        let range: ClosedRange<Int> = 0...5
        let strings = String.arbitrary
            .proliferate(in: range)
            .take()

        XCTAssert(strings.allSatisfy { s in
            range.lowerBound <= s.count && s.count <= range.upperBound
        })
    }
}
