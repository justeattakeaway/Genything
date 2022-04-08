@testable import Genything
import GenythingTest
import XCTest

final class Generator_FilterTests: XCTestCase {
    func test_filter_works_as_expected_with_reasonable_input() {
        let testEven = { ($0 % 2) == 0 }
        let gen = Int.arbitrary.filter(testEven)
        
        testAllSatisfy(gen) {
            testEven($0)
        }
    }
}
