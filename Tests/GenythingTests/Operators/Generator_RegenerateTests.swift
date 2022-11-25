import GenythingTest
import XCTest
@testable import Genything

final class Generator_RegenerateTests: XCTestCase {
    func test_givenArbitraryPizzas_whenWeAddLimitationsToAField_theLimitationsAreRespected() {
        let sizeFilter = Pizza.Size.allCases.filter {
            [Pizza.Size.medium, .large].contains($0)
        }.arbitrary

        let pizzas = Pizza.arbitrary
            .regenerate { pizza, randomSource in
                pizza.size = sizeFilter.next(randomSource)
            }

        TestSuite().testAllSatisfy(pizzas) {
            $0.size == .large || $0.size == .medium
        }
    }
}
