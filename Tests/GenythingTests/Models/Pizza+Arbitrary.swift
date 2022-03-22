@testable import Genything

// MARK: - Pizza + Arbitrary

extension Pizza: Arbitrary {
    public static var arbitrary: AnyGenerator<Pizza> {
        AnyGenerator { rs in
            Pizza(
                name: .arbitrary.next(rs),
                size: .arbitrary.next(rs),
                toppings: .arbitrary.next(rs)
            )
        }
    }
}

// MARK: - Pizza.Topping + Arbitrary

extension Pizza.Topping: Arbitrary {
    public static var arbitrary: AnyGenerator<Pizza.Topping> {
        String.arbitrary
            .map(Pizza.Topping.init)
    }
}
