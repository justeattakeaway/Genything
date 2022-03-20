import XCTest
@testable import Genything
import GenythingTest

final internal class GenRecomposeTests: XCTestCase {
    func test_givenArbitraryPizzas_whenWeAddLimitationsToAField_theLimitationsAreRespected() {

        let sizeFilter = Pizza.Size.allCases.filter {
            [Pizza.Size.medium, .large].contains($0)
        }.arbitrary

        Pizza.arbitrary
            .recompose { pizza, compose in
                pizza.size = compose(sizeFilter)
            }
            .assertForAll {
                $0.size == .large || $0.size == .medium
            }
    }
}
