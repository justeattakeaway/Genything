import XCTest
@testable import Genything
import GenythingTest

final internal class GenFromRangeTests: XCTestCase {
    func test_fromElements_usingClosedRangeOf_Integers_IncludesCorrectElements() {
        testAllSatisfy(Generators.from(0...100)) {
            $0 >= 0 && $0 <= 100
        }
    }

    func test_fromElements_usingClosedRangeOf_Integers_IncludesAllElements() {
        testAllSatisfy(Generators.from(0...1)) {
            $0 == 0 || $0 == 1
        }
    }

    func test_fromElements_usingRangeOf_Integers_DoesNotIncludeLastElement() {
        testAllSatisfy(Generators.from(0..<1)) {
            $0 == 0
        }
    }

    func test_fromElements_usingClosedRangeOf_Characters_IncludesCorrectElements() {
        testAllSatisfy(Generators.from(Character("a")...Character("z"))) {
             $0.isLowercase
         }
    }

    func test_fromElements_usingClosedRangeOf_Characters_IncludesAllElements() {
        testAllSatisfy(Generators.from(Character("a")...Character("b"))) {
            $0 == "a" || $0 == "b"
        }
    }

    func test_fromElements_usingRangeOf_Characters_DoesNotIncludeLastElement() {
        testAllSatisfy(Generators.from(Character("a")..<Character("b"))) {
            $0 == "a"
        }
    }
}
