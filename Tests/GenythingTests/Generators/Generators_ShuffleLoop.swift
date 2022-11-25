import Foundation
import GenythingTest
import XCTest
@testable import Genything

final class Generators_ShuffleLoopTests: XCTestCase {
    func test_ExhaustiveShuffleLoop() {
        let d6shuffle = Generators.shuffleLoop(Array(1 ... 6))

        var history = [Int]()

        TestSuite().testAll(d6shuffle) {
            if history.count >= 6 {
                history.removeAll()
            }

            XCTAssertFalse(history.contains($0))

            history.append($0)
        }
    }

    func test_ExhaustiveShuffleLoop_deckOfCardsMetaphor() {
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

        let cardGen = Generators.shuffleLoop(
            Rank.allCases.map { rank in
                Suit.allCases.map { suit in Card(suit: suit, rank: rank) }
            }.flatMap { $0 }
        )

        // All cards of the deck are drawn, and they are all unique
        XCTAssertEqual(52, Set<Card>(cardGen.take(52, randomSource: .predetermined())).count)

        // Drawing more from the deck takes from a newly shuffled pile and will repeat values
        XCTAssertEqual(52, Set<Card>(cardGen.take(53, randomSource: .predetermined())).count)
    }
}
