import XCTest
import Foundation
import Genything
import GenythingTest

final internal class DiceRollerExampleTests: XCTestCase {
    /// An extremely simple dice
    private let d6 = (1...6).arbitrary

    func test_d6_bounds() {
        // All values are within the expected bounds
        d6.assertForAll {
            1...6 ~= $0
        }
    }

    func test_d6_occurences() {
        // All values occur in a small sample size
        let occurences = d6.take(50)
        XCTAssertTrue(occurences.contains(1))
        XCTAssertTrue(occurences.contains(2))
        XCTAssertTrue(occurences.contains(3))
        XCTAssertTrue(occurences.contains(4))
        XCTAssertTrue(occurences.contains(5))
        XCTAssertTrue(occurences.contains(6))
    }

    func test_d6_mean() {
        // With a large sample size the mean is very close to 3.5
        let occurences = d6.take(1_000_000)
        let mean = Double(occurences.reduce(0, +)) / Double(occurences.count)
        XCTAssertEqual(mean, 3.5, accuracy: 0.005)
    }

    /// Experiment with some ways of creating a dice roll with multiple die
    func test_ways_of_creating_a_dice_bag() {
        let d6 = (1...6).arbitrary

        let two_d6 = d6.zip(d6) { $0 + $1 }

        two_d6.assertForAll {
            2...12 ~= $0
        }

        let two_d6_2 = Generators.compose { $0(d6) + $0(d6) }

        two_d6_2.assertForAll {
            2...12 ~= $0
        }

        let two_d6_3 = Generators.collect([d6, d6]).map { $0.reduce(0, +) }

        two_d6_3.assertForAll {
            2...12 ~= $0
        }

        let two_d6_4 = Generators.reduce([d6, d6], 0, +)

        two_d6_4.assertForAll {
            2...12 ~= $0
        }
    }

    /// Create a dice rolling helper function using the knowledge gained from `test_ways_of_creating_a_dice_bag`
    func diceRoller(_ dice: [AnyGenerator<Int>], modifier: Int = 0) -> AnyGenerator<Int> {
        Generators.reduce(dice, modifier, +)
    }

    /// Simulate a pen and paper roleplaying dice role
    func test_a_damage_roll_using_two_daggers_with_a_modifier() {
        let d4 = (1...4).arbitrary
        let twoDaggers = diceRoller([d4, d4], modifier: 2)

        twoDaggers.assertForAll {
            4...10 ~= $0
        }

        let occurences = twoDaggers
            .take(1000)

        XCTAssertTrue(occurences.contains(4))
        XCTAssertTrue(occurences.contains(5))
        XCTAssertTrue(occurences.contains(6))
        XCTAssertTrue(occurences.contains(7))
        XCTAssertTrue(occurences.contains(8))
        XCTAssertTrue(occurences.contains(9))
        XCTAssertTrue(occurences.contains(10))
    }
}
