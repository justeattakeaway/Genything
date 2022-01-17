import XCTest
@testable import Genything

final internal class GenWithEdgeCasesTests: XCTestCase {
    func test_with_edgecases_generates_edgecases() {
        let context = Context.default
        context.edgeCaseProbability = 0.5

        let nonEmptyStrings = Character.arbitrary.expand(toSizeInRange: 1...10).map { String($0) }

        let emptyAndNonEmptyStrings = nonEmptyStrings
            .withEdgeCases([""])
            .take(count: 1000, context: context)

        let countEdgecases = emptyAndNonEmptyStrings.filter { $0.isEmpty }.count

        assertAcceptableDelta(total: 1000, actual: countEdgecases, acceptablePercentDelta: 0.01)
    }

    func test_with_edgecases_does_not_generate_edgecases_if_context_demands_it() {
        let context = Context.default
        context.edgeCaseProbability = 0

        let notEdgecaseValue = "NOT EDGECASE"
        let edgecaseValue = "EDGECASE"

        XCTAssertTrue(
            Gen.constant(notEdgecaseValue)
                .withEdgeCases([edgecaseValue])
                .take(count: 1000, context: context)
                .filter { $0 == edgecaseValue }.isEmpty
        )
    }
}
