import XCTest
@testable import Genything

final internal class GenWithEdgeCasesTests: XCTestCase {
    func test_with_edgecases_generates_edgecases() {
        let context = Context.default
        context.edgeCaseProbability = 0.1

        let nonEmptyStrings = Character.arbitrary.expand(toSizeInRange: 1...10).map { String($0) }

        let iterations = 1000
        let emptyAndNonEmptyStrings = nonEmptyStrings
            .withEdgeCases([""])
            .take(iterations, context: context)

        let countEdgecases = emptyAndNonEmptyStrings.filter { $0.isEmpty }.count

        XCTAssertEqual(Double(countEdgecases), Double(iterations) * context.edgeCaseProbability, accuracy: 10.0)
    }

    func test_with_edgecases_does_not_generate_edgecases_if_context_demands_it() {
        let context = Context.default
        context.edgeCaseProbability = 0

        let notEdgecaseValue = "NOT EDGECASE"
        let edgecaseValue = "EDGECASE"

        XCTAssertTrue(
            Gen.constant(notEdgecaseValue)
                .withEdgeCases([edgecaseValue])
                .take(1000, context: context)
                .filter { $0 == edgecaseValue }.isEmpty
        )
    }
}
