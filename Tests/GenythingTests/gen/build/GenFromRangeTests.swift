import XCTest
@testable import Genything
import GenythingTest

final internal class GenFromRangeTests: XCTestCase {
    func test_fromElements_usingClosedRangeOf_Integers_IncludesCorrectElements() {
        Generators.from(0...100).assertForAll {
            $0 >= 0 && $0 <= 100
        }
    }

    func test_fromElements_usingClosedRangeOf_Integers_IncludesAllElements() {
        Generators.from(0...1).assertForAll {
            $0 == 0 || $0 == 1
        }
    }

    func test_fromElements_usingRangeOf_Integers_DoesNotIncludeLastElement() {
        Generators.from(0..<1).assertForAll {
            $0 == 0
        }
    }

    func test_fromElements_usingClosedRangeOf_Characters_IncludesCorrectElements() {
        /*
         // TODO
         Gen<Character>.from("a"..."z").assertForAll {
             $0.isLowercase
         }
         */
        Generators.from(Character("a")...Character("z")).assertForAll {
            $0.isLowercase
        }
    }

    func test_fromElements_usingClosedRangeOf_Characters_IncludesAllElements() {
        Generators.from(Character("a")...Character("b")).assertForAll {
            $0 == "a" || $0 == "b"
        }
    }

    func test_fromElements_usingRangeOf_Characters_DoesNotIncludeLastElement() {
        Generators.from(Character("a")..<Character("b")).assertForAll {
            $0 == "a"
        }
    }
}
