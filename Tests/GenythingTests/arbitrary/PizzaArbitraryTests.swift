import XCTest
@testable import Genything

/*
 Using generators we can generate ARBITRARY test data.
    We call it "arbitrary" instead of "random" because the Generation is smart!
    - You can specify a seed value, so that the tests run with the same "randomness" in repeated executions.
    - You can alter the chances of conditions. Increase the likelyhood of conditions. Filter only certain conditions.
 */
final internal class PizzaArbitraryGeneratableTests: XCTestCase {
    func test_usingFixtures_withNoToppings_itIsACheesePizza() {
        let pizzaGen = AnyGenerator.compose {
            Pizza(name: $0(),
                  size: $0(),
                  toppings: []) // No toppings => Cheese pizza!
        }

        // Read as:
        // For any pizza produced by `pizzaGen`, the pizza is a cheese pizza
        pizzaGen.take(100) /// Takes 100 random pizzas
            .forEach { (pizza: Pizza) in
                XCTAssertTrue(pizza.isCheesePizza)
        }
        // Note how we gain an extra level of confidence!
        // Thanks to checking edge-cases that could result from different sizes & names
    }

    func test_usingFixtures_withToppings_itIsNotACheesePizza() {
        let pizzaGen = Pizza.arbitrary          /// Pseudo-random pizzas
            .filter { !$0.toppings.isEmpty }    /// Reject pizzas without toppings

        // Read as:
        // For any pizza produced by `pizzaGen`, the pizza is not a cheese pizza
        pizzaGen.assertForAll { (pizza: Pizza) in
            !pizza.isCheesePizza
        }
    }

    func test_pizzaGeneration_usingEither_generatesWithCorrectFrequency() {
        let pepperoni = "Pepperoni"


        let pepperoniPizzaGen = AnyGenerator.compose {
            Pizza(name: pepperoni,
                  size: $0(),
                  toppings: [pepperoni].map { Pizza.Topping(name: $0) })
        }

        let hawaiian = "Hawaiian"
        let hawaiianPizzaGen = AnyGenerator.compose {
            Pizza(name: hawaiian,
                  size: $0(),
                  toppings: ["ham", "pineapple"].map { Pizza.Topping(name: $0) })
        }

        let pizzaDistribution = Generators.either(left: hawaiianPizzaGen, right: pepperoniPizzaGen, rightProbability: 0.75)

        // Take a statistical sample of pizzas
        let pizzas = pizzaDistribution.take(1000)

        func pizzaQuotient(_ pizzaName: String) -> Double {
            let countOfPizzaName = pizzas.filter { $0.name == pizzaName }.count
            return Double(countOfPizzaName) / Double(pizzas.count)
        }

        XCTAssertEqual(pizzaQuotient(hawaiian), 0.25, accuracy: 0.05)
        XCTAssertEqual(pizzaQuotient(pepperoni), 0.75, accuracy: 0.05)
    }
}
