import XCTest
@testable import Genything
import GenythingTest

final internal class GenExpandTests: XCTestCase {
    func test_expand_toSize_createsWithCorrectSize() {
        let size = 10
        String.arbitrary
            .expand(toSize: size)
            .xctest { s in
                s.count == size
            }
    }

    func test_expand_toSizeInRange_createsInsideCorrectBounds() {
        let range: Range<Int> = 0..<5
        String.arbitrary
            .expand(toSizeInRange: range)
            .xctest { s in
                range.lowerBound <= s.count && s.count <= range.upperBound
            }
    }

    func test_expand_toSizeInClosedRange_createsInsideCorrectBounds() {
        let range: ClosedRange<Int> = 0...5
        String.arbitrary
            .expand(toSizeInRange: range)
            .xctest { s in
                range.lowerBound <= s.count && s.count <= range.upperBound
            }
    }
}
