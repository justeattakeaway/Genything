import Foundation
@testable import Genything
import XCTest

final internal class GenShuffledTests: XCTestCase {
    func test_shuffled() {
        let source = [0,1,2,3,4,5,6,7,8,9]

        // Seed the context such that we can reproduce results with or without the generator
        let seed: UInt64 = 1234
        let context = Context(using: LinearCongruentialRandomNumberGenerator(seed: seed), originalSeed: seed)

        // Take 100 shuffles
        let shuffledViaGeneratorList = Gen.shuffled(source)
            .take(100, context: context)

        // Make sure that these shuffles match doing normal shuffles without a generator
        var collectionsLCRNG = LinearCongruentialRandomNumberGenerator(seed: seed)
        for shuffledViaGenerator in shuffledViaGeneratorList {
            XCTAssertEqual(shuffledViaGenerator, source.shuffled(using: &collectionsLCRNG))
        }
    }

    func test_shuffledDistribution() {
        let d6shuffle = Gen<Int>.shuffledDistribution(Array(1...6))

        var history = [Int]()

        d6shuffle.forEach {
            if history.count >= 6 {
                history.removeAll()
            }

            XCTAssertFalse(history.contains($0))

            history.append($0)
        }
    }

    func test_shuffledDistribution_deckOfCardsMetaphor() {
        enum Suit: CaseIterable {
            case heart, spade, club, diamond
        }

        enum Rank: CaseIterable {
            case ace, two, three, four, five, six, seven, eight, nine, ten, jack, queen, king
        }

        struct Card: Equatable, Hashable {
            var suit: Suit
            var rank: Rank
        }

        let cardGen = Gen<Card>.shuffledDistribution(
            Rank.allCases.map { rank in Suit.allCases.map { suit in Card(suit: suit, rank: rank) }}
                .flatMap { $0 }
        )

        // All cards of the deck are drawn, and they are all unique
        XCTAssertEqual(52, Set<Card>(cardGen.take(52)).count)

        // Drawing more from the deck takes from a newly shuffled pile and will repeat values
        XCTAssertEqual(52, Set<Card>(cardGen.take(53)).count)
    }
}
