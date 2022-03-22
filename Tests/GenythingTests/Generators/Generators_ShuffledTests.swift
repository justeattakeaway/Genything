import Foundation
@testable import Genything
import GenythingTest
import XCTest

final internal class Generators_ShuffledTests: XCTestCase {
    func test_shuffled() {
        let source = [0,1,2,3,4,5,6,7,8,9]

        // Seed the randomSource such that we can reproduce results with or without the generator
        let seed: UInt64 = 1234
        let randomSource = RandomSource(using: LinearCongruentialRandomNumberGenerator(seed: seed), originalSeed: seed)

        // Take 100 shuffles
        let shuffledViaGeneratorList = Generators.shuffled(source)
            .take(100, randomSource: randomSource)

        // Make sure that these shuffles match doing normal shuffles without a generator
        var collectionsLCRNG = LinearCongruentialRandomNumberGenerator(seed: seed)
        for shuffledViaGenerator in shuffledViaGeneratorList {
            XCTAssertEqual(shuffledViaGenerator, source.shuffled(using: &collectionsLCRNG))
        }
    }
}
