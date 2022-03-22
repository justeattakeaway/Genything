import Foundation
import Genything

// MARK: Model

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

extension Pizza.Size: CaseIterable {}

extension Pizza {
    var isCheesePizza: Bool {
        return toppings.isEmpty
    }
}
