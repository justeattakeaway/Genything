import XCTest
@testable import Genything

//final internal class GenWithEdgeCasesTests: XCTestCase {
//    func test_with_edgecases_generates_edgecases() {
//        let randomSource = Context.default
//        randomSource.edgeCaseProbability = 0.1
//
//        let nonEmptyStrings = Character.arbitrary.expand(toSizeInRange: 1...10).map { String($0) }
//
//        let iterations = 1000
//        let emptyAndNonEmptyStrings = nonEmptyStrings
//            .withEdgeCases([""])
//            .take(iterations, randomSource: randomSource)
//
//        let countEdgecases = emptyAndNonEmptyStrings.filter { $0.isEmpty }.count
//
//        XCTAssertEqual(Double(countEdgecases), Double(iterations) * randomSource.edgeCaseProbability, accuracy: 10.0)
//    }
//
//    func test_with_edgecases_does_not_generate_edgecases_if_randomSource_demands_it() {
//        let randomSource = Context.default
//        randomSource.edgeCaseProbability = 0
//
//        let notEdgecaseValue = "NOT EDGECASE"
//        let edgecaseValue = "EDGECASE"
//
//        XCTAssertTrue(
//            Generators.Constant(notEdgecaseValue)
//                .withEdgeCases([edgecaseValue])
//                .take(1000, randomSource: randomSource)
//                .filter { $0 == edgecaseValue }.isEmpty
//        )
//    }
//
//    func test_edgeCases_changing_randomSources() {
//        let mainCase = 0
//        let edgeCase = 1
//
//        let gen = Gen.of([mainCase])
//            .withEdgeCases([edgeCase])
//
//        let randomSource1 = Context.default
//        randomSource1.edgeCaseProbability = 0.0
//
//        let value1 = gen.generate(randomSource: randomSource1)
//        XCTAssertEqual(value1, mainCase)
//
//        let randomSource2 = Context.default
//        randomSource2.edgeCaseProbability = 1.0
//
//        let value2 = gen.generate(randomSource: randomSource2)
//        XCTAssertEqual(value2, edgeCase)
//
//        let randomSource3 = Context.default
//        randomSource3.edgeCaseProbability = 0.0
//
//        let value3 = gen.generate(randomSource: randomSource3)
//        XCTAssertEqual(value3, mainCase)
//    }
//}
