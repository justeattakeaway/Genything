@testable import Genything

extension Pizza: Arbitrary {
    public static var arbitrary: Gen<Pizza> {
        Gen.compose {
            Pizza(
                name: $0.arbitrary(),
                size: $0.arbitrary(),
                toppings: $0.arbitrary()
            )
        }
    }
}

extension Pizza.Size: Arbitrary {
    public static var arbitrary: Gen<Pizza.Size> {
        .ofCases()
    }
}

extension Pizza.Topping: Arbitrary {
    public static var arbitrary: Gen<Pizza.Topping> {
        String.arbitrary.map(Pizza.Topping.init)
    }
}
