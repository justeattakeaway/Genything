import Foundation
import Genything

// MARK: - Pizza

struct Pizza: Equatable {
    var name: String
    var size: Size
    var toppings: [Topping]

    enum Size: Equatable {
        case small
        case medium
        case large
        case xl
    }

    struct Topping: Equatable {
        let name: String
    }
}

// MARK: - Pizza.Size + CaseIterable

extension Pizza.Size: CaseIterable {}

extension Pizza {
    var isCheesePizza: Bool {
        toppings.isEmpty
    }
}
