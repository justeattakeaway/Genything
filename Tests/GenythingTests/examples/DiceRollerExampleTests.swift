import XCTest
import Foundation
import Genything
import GenythingTest

final internal class DiceRollerExampleTests: XCTestCase {
    /// An extremely simple dice roll
    func test_d6() {
        let d6 = Gen<Int>.from(1...6)

        d6.assertForAll {
            1...6 ~= $0
        }
    }

    /// Experiment with some ways of creating a dice roll with multiple die
    func test_ways_of_creating_a_dice_bag() {
        let d6 = Gen<Int>.from(1...6)

        let two_d6 = d6.zip(with: d6).map { $0 + $1 }

        two_d6.assertForAll {
            2...12 ~= $0
        }

        let two_d6_2 = Gen.compose { $0.generate(d6) + $0.generate(d6) }

        two_d6_2.assertForAll {
            2...12 ~= $0
        }

        let two_d6_3 = Gen.collect([d6, d6]).map { $0.reduce(0, +) }

        two_d6_3.assertForAll {
            2...12 ~= $0
        }

        let two_d6_4 = Gen.reduce([d6, d6], 0, +)

        two_d6_4.assertForAll {
            2...12 ~= $0
        }
    }

    /// Create a dice rolling helper function using the knowledge gained from `test_ways_of_creating_a_dice_bag`
    func diceRoller(_ dice: [Gen<Int>], modifier: Int = 0) -> Gen<Int> {
        Gen.reduce(dice, modifier, +)
    }

    func test_a_damage_roll_using_two_daggers_with_a_modifier() {
        let d4 = Gen<Int>.from(1...4)
        let twoDaggers = diceRoller([d4, d4], modifier: 2)

        twoDaggers.assertForAll {
            4...10 ~= $0
        }
    }
}
