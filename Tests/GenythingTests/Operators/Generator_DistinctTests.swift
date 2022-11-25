import GenythingTest
import XCTest
@testable import Genything

final class Generator_DistinctTests: XCTestCase {
    func test_removeDuplicates_works_where_it_is_reasonable() {
        // A generator of bits (0 or 1) with duplicates removed
        // There is a 50% chance of generating the correct value to satisfy the duplicate requirement, so as long as we can generate more than one value we can be confident that this function will succeed.
        let bitGenerator = (0...1).arbitrary.removeDuplicates()

        var last: Int? // Storage for the last bit we generated
        TestSuite().testAllSatisfy(bitGenerator) { bit in
            defer { last = bit } // Store the bit for the next comparison
            if let last = last, last == bit {
                // If this bit matches the last, the function does not work as expected
                return false
            }
            return true
        }
    }
}
