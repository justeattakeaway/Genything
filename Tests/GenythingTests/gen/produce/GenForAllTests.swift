import XCTest
@testable import Genything
import GenythingTest

final internal class GenForAllTests: XCTestCase {
    func test_forAll_meta() {
//        Gen.from(0...100).take().forEach { count in
//            var i = 0
//            Int.arbitrary.take(count: count).forEach { _ in
//                i += 1
//            }
//
//            XCTAssertEqual(i, count)
//        }
//

        Gen.from(0...10).xctest { n in
            return n > 0 // This obviously fails for 0
        }
    }

    func test_forAll_practical() {
        let foodMod = Gen.of(["Cheese", "Banana", "Chicken", "Crispy", "Smoked", "Vegan"])

        let foodType = Gen.of(["Pizza", "Burrito", "Donair", "Toast", "Salad", "Sandwich"])

        Gen.zip(foodMod, foodType).take().forEach {
            let menuItem = $0 + " " + $1
            XCTAssertNotNil($0)
            XCTAssertNotNil($1)
            XCTAssertNotNil(menuItem)
        }
    }
}
