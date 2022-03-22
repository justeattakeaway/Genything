import XCTest
@testable import Genything
import GenythingTest

final internal class GenFromRangeTests: XCTestCase {
    func test_fromElements_usingClosedRangeOf_Integers_IncludesCorrectElements() {
        testAllSatisfy((0...100).arbitrary) {
            $0 >= 0 && $0 <= 100
        }
    }

    func test_fromElements_usingClosedRangeOf_Integers_IncludesAllElements() {
        testAllSatisfy((0...1).arbitrary) {
            $0 == 0 || $0 == 1
        }
    }

    func test_fromElements_usingRangeOf_Integers_DoesNotIncludeLastElement() {
        testAllSatisfy((0..<1).arbitrary) {
            $0 == 0
        }
    }

    func test_fromElements_usingClosedRangeOf_Characters_IncludesCorrectElements() {
        testAllSatisfy((Character("a")...Character("z")).arbitrary) {
             $0.isLowercase
         }
    }

    func test_fromElements_usingClosedRangeOf_Characters_IncludesAllElements() {
        testAllSatisfy((Character("a")...Character("b")).arbitrary) {
            $0 == "a" || $0 == "b"
        }
    }

    func test_fromElements_usingRangeOf_Characters_DoesNotIncludeLastElement() {
        testAllSatisfy((Character("a")..<Character("b")).arbitrary) {
            $0 == "a"
        }
    }
}
