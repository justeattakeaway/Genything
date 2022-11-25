import GenythingTest
import XCTest
@testable import Genything

internal final class ArbitraryRangeTests: XCTestCase {
    func test_fromElements_usingClosedRangeOf_Integers_IncludesCorrectElements() {
        TestSuite().testAllSatisfy((0 ... 100).arbitrary) {
            $0 >= 0 && $0 <= 100
        }
    }

    func test_fromElements_usingClosedRangeOf_Integers_IncludesAllElements() {
        TestSuite().testAllSatisfy((0 ... 1).arbitrary) {
            $0 == 0 || $0 == 1
        }
    }

    func test_fromElements_usingRangeOf_Integers_DoesNotIncludeLastElement() {
        TestSuite().testAllSatisfy((0 ..< 1).arbitrary) {
            $0 == 0
        }
    }

    func test_fromElements_usingClosedRangeOf_Characters_IncludesCorrectElements() {
        TestSuite().testAllSatisfy((Character("a") ... Character("z")).arbitrary) {
            $0.isLowercase
        }
    }

    func test_fromElements_usingClosedRangeOf_Characters_IncludesAllElements() {
        TestSuite().testAllSatisfy((Character("a") ... Character("b")).arbitrary) {
            $0 == "a" || $0 == "b"
        }
    }

    func test_fromElements_usingRangeOf_Characters_DoesNotIncludeLastElement() {
        TestSuite().testAllSatisfy((Character("a") ..< Character("b")).arbitrary) {
            $0 == "a"
        }
    }
}
