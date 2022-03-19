@testable import Genything

extension Pizza: ArbitraryGeneratable {
    public static var arbitrary: AnyGenerator<Pizza> {
        AnyGenerator.compose { generate in
            Pizza(
                name: generate(),
                size: generate(),
                toppings: generate()
            )
        }.eraseToAnyGenerator()
    }
}

extension Pizza.Topping: ArbitraryGeneratable {
    public static var arbitrary: AnyGenerator<Pizza.Topping> {
        String.arbitrary
            .map(Pizza.Topping.init)
            .eraseToAnyGenerator()
    }
}
