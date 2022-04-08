@testable import Genything
import GenythingTest
import XCTest

final class Generator_FilterTests: XCTestCase {
    func test_filter_works_as_expected_with_reasonable_input() {
        let isEven = { ($0 % 2) == 0 } // `1/2` chance of occuring
        let gen = Int.arbitrary.filter(isEven)
        
        testAllSatisfy(gen) {
            isEven($0)
        }
    }
    
    func test_filter_cannot_always_deliver_results_in_reasonable_time() {
        XCTExpectFailure("A ridiculous amount of calculation can be required to satisfy a poorly implemented filter.")
        
        let expectation = expectation(description: "This expectation would take an immense amount of time to be satisfied.")
        
        DispatchQueue.global(qos: .default).async {
            let isDigit = { $0 >= 0 && $0 < 10 } // `10/1.8446744e+19` chance of occuring
            let gen = Int.arbitrary.filter(isDigit)
            
            self.testAllSatisfy(gen) {
                isDigit($0)
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 3)
    }
}
