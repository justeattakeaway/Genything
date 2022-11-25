import GenythingTest
import XCTest
@testable import Genything

final class Generator_RecomposeTests: XCTestCase {
    func test_givenArbitraryPizzas_whenWeAddLimitationsToAField_theLimitationsAreRespected() {
        let sizeFilter = Pizza.Size.allCases.filter {
            [Pizza.Size.medium, .large].contains($0)
        }.arbitrary

        let gen = Pizza.arbitrary
            .recompose { pizza, compose in
                pizza.size = compose(sizeFilter)
            }

        TestSuite().testAllSatisfy(gen) {
            $0.size == .large || $0.size == .medium
        }
    }
}
