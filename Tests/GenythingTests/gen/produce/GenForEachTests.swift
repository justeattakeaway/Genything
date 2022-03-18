import XCTest
@testable import Genything

final internal class GenForEachTests: XCTestCase {
    func test_forEach_iterations_parameter() {
        Generators.from(0...100).forEach(100) { count in
            var i = 0
            Int.arbitrary.forEach(count) { _ in
                i += 1
            }

            XCTAssertEqual(i, count)
        }
    }

    func test_forEach_practical() {
        let foodMod = Generators.of(["Cheese", "Banana", "Chicken", "Crispy", "Smoked", "Vegan"])

        let foodType = Generators.of(["Pizza", "Burrito", "Donair", "Toast", "Salad", "Sandwich"])

        Generators.zip(foodMod, foodType).forEach(1000) {
            let menuItem = $0 + " " + $1
            XCTAssertNotNil($0)
            XCTAssertNotNil($1)
            XCTAssertNotNil(menuItem)
        }
    }
}
