import XCTest
@testable import Genything
import GenythingTest

final internal class GenFromRangeTests: XCTestCase {
    func test_fromElements_usingClosedRangeOf_Integers_IncludesCorrectElements() {
        Gen.from(0...100).xctest {
            $0 >= 0 && $0 <= 100
        }
    }

    func test_fromElements_usingClosedRangeOf_Integers_IncludesAllElements() {
        Gen.from(0...1).xctest {
            $0 == 0 || $0 == 1
        }
    }

    func test_fromElements_usingRangeOf_Integers_DoesNotIncludeLastElement() {
        Gen.from(0..<1).xctest {
            $0 == 0
        }
    }

    func test_fromElements_usingClosedRangeOf_Characters_IncludesCorrectElements() {
        Gen<Character>.from("a"..."z").xctest {
            $0.isLowercase
        }
    }

    func test_fromElements_usingClosedRangeOf_Characters_IncludesAllElements() {
        Gen<Character>.from("a"..."b").xctest {
            $0 == "a" || $0 == "b"
        }
    }

    func test_fromElements_usingRangeOf_Characters_DoesNotIncludeLastElement() {
        Gen<Character>.from("a"..<"b").xctest {
            $0 == "a"
        }
    }
}
