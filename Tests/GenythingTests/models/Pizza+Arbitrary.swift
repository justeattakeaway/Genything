@testable import Genything

extension Pizza: Arbitrary {
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

extension Pizza.Size: Arbitrary {
    public static var arbitrary: AnyGenerator<Pizza.Size> {
        AnyGenerator<Pizza.Size>.ofCases()
    }
}

extension Pizza.Topping: Arbitrary {
    public static var arbitrary: AnyGenerator<Pizza.Topping> {
        String.arbitrary
            .map(Pizza.Topping.init)
            .eraseToAnyGenerator()
    }
}
