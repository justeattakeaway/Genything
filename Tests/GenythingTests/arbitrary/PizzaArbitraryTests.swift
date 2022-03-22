import XCTest
import GenythingTest
@testable import Genything

/*
 Using generators we can generate ARBITRARY test data.
    We call it "arbitrary" instead of "random" because the Generation is smart!
    - You can specify a seed value, so that the tests run with the same "randomness" in repeated executions.
    - You can alter the chances of conditions. Increase the likelyhood of conditions. Filter only certain conditions.
 */
final internal class PizzaArbitraryGeneratableTests: XCTestCase {
    func test_usingFixtures_withNoToppings_itIsACheesePizza() {
        let pizzaGen = Generators.compose {
            Pizza(name: $0(),
                  size: $0(),
                  toppings: []) // No toppings => Cheese pizza!
        }

        // Read as:
        // For any pizza produced by `pizzaGen`, the pizza is a cheese pizza
        testAllSatisfy(pizzaGen) { pizza in
            pizza.isCheesePizza
        }
        // Note how we gain an extra level of confidence!
        // Thanks to checking edge-cases that could result from different sizes & names
    }

    func test_usingFixtures_withToppings_itIsNotACheesePizza() {
        let pizzaGen = Pizza.arbitrary
            .recompose { pizza, compose in
                /// Be sure that `toppings` is not empty
                pizza.toppings = compose([Pizza.Topping].arbitrary(in: 1...10))
            }

        // Read as:
        // For any pizza produced by `pizzaGen`, the pizza is not a cheese pizza
        testAllSatisfy(pizzaGen) { pizza in
            !pizza.isCheesePizza
        }
    }

    func test_pizzaGeneration_usingEither_generatesWithCorrectFrequency() {
        let pepperoni = "Pepperoni"


        let pepperoniPizzaGen = Generators.compose {
            Pizza(name: pepperoni,
                  size: $0(),
                  toppings: [pepperoni].map { Pizza.Topping(name: $0) })
        }

        let hawaiian = "Hawaiian"
        let hawaiianPizzaGen = Generators.compose {
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
