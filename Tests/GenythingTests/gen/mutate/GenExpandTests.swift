import XCTest
@testable import Genything

final internal class GenExpandTests: XCTestCase {
    func test_proliferate_withSize_createsWithCorrectSize() {
        let size = 10
        let strings = String.arbitrary
            .expand(toSize: size)
            .take()

        XCTAssert(strings.allSatisfy { s in
            s.count == size
        })
    }

    func test_proliferate_inRange_createsInsideCorrectBounds() {
        let range: Range<Int> = 0..<5
        let strings = String.arbitrary
            .expand(toSizeInRange: range)
            .take()

        XCTAssert(strings.allSatisfy { s in
            range.lowerBound <= s.count && s.count <= range.upperBound
        })
    }

    func test_proliferate_inClosedRange_createsInsideCorrectBounds() {
        let range: ClosedRange<Int> = 0...5
        let strings = String.arbitrary
            .expand(toSizeInRange: range)
            .take()

        XCTAssert(strings.allSatisfy { s in
            range.lowerBound <= s.count && s.count <= range.upperBound
        })
    }
}
