@testable import Genything

extension Pizza: ArbitraryGeneratable {
    public static var arbitrary: AnyGenerator<Pizza> {
        AnyGenerator.compose {
            Pizza(
                name: $0.arbitrary(),
                size: $0.arbitrary(),
                toppings: $0.arbitrary()
            )
        }.eraseToAnyGenerator()
    }
}

extension Pizza.Size: ArbitraryGeneratable {
    public static var arbitrary: AnyGenerator<Pizza.Size> {
        Generators.ofCases()
    }
}

extension Pizza.Topping: ArbitraryGeneratable {
    public static var arbitrary: AnyGenerator<Pizza.Topping> {
        String.arbitrary
            .map(Pizza.Topping.init)
            .eraseToAnyGenerator()
    }
}
