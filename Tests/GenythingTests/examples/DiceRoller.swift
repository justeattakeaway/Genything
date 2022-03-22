import XCTest
import Foundation
import Genything
import GenythingTest

final internal class DiceRollerTests: XCTestCase {

    // Let's create a dice
    // It generates arbitrary values in the range 1...6 (inclusive)
    private var d6: AnyGenerator<Int> {
        (1...6).arbitrary
    }

    // Let's verify that all the values are within the expected bounds
    func test_d6_bounds() {
        testAllSatisfy(d6) {
            1...6 ~= $0
        }
    }

    // With enough dice rolls the mean should be very close to 3.5
    func test_d6_mean() {
        let occurences = d6.take(1_000_000)
        let mean = Double(occurences.reduce(0, +)) / Double(occurences.count)
        XCTAssertEqual(mean, 3.5, accuracy: 0.005)
    }

    // Let's experiment with how we can combine multiple die
    func test_ways_of_creating_a_dice_bag() {
        // we can zip the die together
        let two_d6 = d6.zip(d6) { $0 + $1 }

        // and we get the expected result
        testAllSatisfy(two_d6) {
            2...12 ~= $0
        }

        // we can collect the die into a collection of results
        // then we can use standard Swift collection functions
        let two_d6_2 = Generators.collect([d6, d6]).map { $0.reduce(0, +) }

        // and we get the expected result
        testAllSatisfy(two_d6_2) {
            2...12 ~= $0
        }

        // we can shortcut the above collect + map + reduce
        // by using a built-in genything reducing function
        let two_d6_3 = Generators.reduce([d6, d6], 0, +)

        // and we get the expected result
        testAllSatisfy(two_d6_3) {
            2...12 ~= $0
        }
    }

    // Let's use the knowledge we've gained to create a dice rolling helper function
    func roll(_ dice: [AnyGenerator<Int>], modifier: Int = 0) -> AnyGenerator<Int> {
        Generators.reduce(dice, modifier, +)
    }

    // Now we can simulate a pen and paper roleplaying game
    func test_a_damage_roll_using_two_daggers_with_a_modifier() {
        // A character who has a dagger proficieny bonus of 2
        let daggerProficiencyBonus = 2
        // Will need to roll 2d4+2 to calculate damage

        // We create the d4 die
        let d4 = (1...4).arbitrary
        // Which we can then use to perform a damage roll
        let twoDaggers = roll([d4, d4], modifier: daggerProficiencyBonus)

        // Which will only produce results in the expected damage range
        testAllSatisfy(twoDaggers) {
            4...10 ~= $0
        }
    }
}
