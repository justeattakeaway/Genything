@testable import Genything

extension Pizza: Arbitrary {
    public static var arbitrary: AnyGenerator<Pizza> {
        Generators.compose { generate in
            Pizza(
                name: generate(),
                size: generate(),
                toppings: generate()
            )
        }
    }
}

extension Pizza.Topping: Arbitrary {
    public static var arbitrary: AnyGenerator<Pizza.Topping> {
        String.arbitrary
            .map(Pizza.Topping.init)
    }
}
