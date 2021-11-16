import XCTest
@testable import Genything

final internal class GenTests: XCTestCase {
    func test_take() {
        let generator = Gen.of([1, 2, 3])

        generator.take(count: 10).forEach { val in
            print(val)
        }
    }

    func test_forAll_meta() {
        Gen.from(0...100).take().forEach { count in
            var i = 0
            Int.arbitrary.take(count: count).forEach { _ in
                i += 1
            }

            XCTAssertEqual(i, count)
        }
    }

    func test_forAll_2() {
        let foodMod = Gen.of(["Cheese", "Banana", "Chicken", "Crispy", "Smoked", "Vegan"])

        let foodType = Gen.of(["Pizza", "Burrito", "Donair", "Toast", "Salad", "Sandwich"])

        Gen.zip(foodMod, foodType).take().forEach {
            let menuItem = $0 + " " + $1
            XCTAssertNotNil($0)
            XCTAssertNotNil($1)
            XCTAssertNotNil(menuItem)
        }
    }

    func test_allSatisfy_true() {
        XCTAssertTrue(
            Gen.zip(
                Gen.from(1...100),
                Gen.from(1...100)
            ).allSatisfy { a, b in
                a >= 1 && a <= 100 && b >= 1 && b <= 100
            }
        )
    }

    func test_allSatisfy_false() {
        XCTAssertFalse(
            Gen.from(1...100).allSatisfy { a in
                a < 1 || a > 100
            }
        )
    }
}
