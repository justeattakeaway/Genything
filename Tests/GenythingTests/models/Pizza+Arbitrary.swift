@testable import Genything

extension Pizza: Arbitrary {
    public static var arbitrary: Gen<Pizza> {
        Gen.compose {
            Pizza(
                name: $0.generate(),
                size: $0.generate(),
                toppings: $0.generate()
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
