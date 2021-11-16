import XCTest
@testable import Genything

/*
 Using generators we can generate ARBITRARY test data.
    We call it "arbitrary" instead of "random" because the Generation is smart!
    - You can specify a seed value, so that the tests run with the same "randomness" in repeated executions.
    - You can alter the chances of conditions. Increase the likelyhood of conditions. Filter only certain conditions.
 */
final internal class PizzaArbitraryTests: XCTestCase {
    func test_usingFixtures_withNoToppings_itIsACheesePizza() {
        let pizzaGen = Pizza.arbitrary.map {
            Pizza(name: $0.name,
                  size: $0.size,
                  toppings: []) /// Modified to never produce Toppings
        }

        // Read as:
        // For any pizza produced by `pizzaGen`, the pizza is a cheese pizza
        pizzaGen.take() /// Takes 100 random pizzas
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
        pizzaGen.take() /// Takes 100 random pizzas
            .forEach { (pizza: Pizza) in
                XCTAssertFalse(pizza.isCheesePizza)
        }
    }

    func test_pizzaGeneration_usingEither_generatesWithCorrectFrequency() {
        let pepperoni = "Pepperoni"
        let pepperoniPizzaGen = Pizza.arbitrary.map {
            Pizza(name: pepperoni,
                  size: $0.size,
                  toppings: [pepperoni].map { Pizza.Topping(name: $0) })
        }

        let hawaiian = "Hawaiian"
        let hawaiianPizzaGen = Pizza.arbitrary.map {
            Pizza(name: hawaiian,
                  size: $0.size,
                  toppings: ["ham", "pineapple"].map { Pizza.Topping(name: $0) })
        }

        let pizzaDistribution = Gen<Pizza>.either(left: hawaiianPizzaGen, right: pepperoniPizzaGen, rightProbability: 0.75)

        // Take a statistical sample of pizzas
        let pizzas = pizzaDistribution.take(count: 1000)

        func pizzaQuotient(_ pizzaName: String) -> Double {
            let countOfPizzaName = pizzas.filter { $0.name == pizzaName }.count
            return Double(countOfPizzaName) / Double(pizzas.count)
        }

        let hawaiianPizzaQuotient = pizzaQuotient(hawaiian)
        XCTAssert(0.2...0.3 ~= hawaiianPizzaQuotient, "Hawaiian generated with quotient \(hawaiianPizzaQuotient)")

        let pepperoniPizzaQuotient = pizzaQuotient(pepperoni)
        XCTAssert(0.7...0.8 ~= pepperoniPizzaQuotient, "Pepperoni generated with quotient \(pepperoniPizzaQuotient)")
    }
}
