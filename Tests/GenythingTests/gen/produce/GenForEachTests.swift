import XCTest
@testable import Genything

final internal class GenForEachTests: XCTestCase {
    func test_forEach_iterations_parameter() {
        Gen.from(0...100).forEach { count in
            var i = 0
            Int.arbitrary.forEach(iterations: count) { _ in
                i += 1
            }

            XCTAssertEqual(i, count)
        }
    }

    func test_forEach_meta() {
        Gen.from(0...100).forEach { count in
            var i = 0
            Int.arbitrary.forEach(iterations: count) { _ in
                i += 1
            }

            XCTAssertEqual(i, count)
        }
    }

    func test_forEach_practical() {
        let foodMod = Gen.of(["Cheese", "Banana", "Chicken", "Crispy", "Smoked", "Vegan"])

        let foodType = Gen.of(["Pizza", "Burrito", "Donair", "Toast", "Salad", "Sandwich"])

        Gen.zip(foodMod, foodType).forEach {
            let menuItem = $0 + " " + $1
            XCTAssertNotNil($0)
            XCTAssertNotNil($1)
            XCTAssertNotNil(menuItem)
        }
    }
}
