import Foundation
import Genything

// MARK: Model

struct Pizza {
    var name: String
    var size: Size
    var toppings: [Topping]

    enum Size {
        case small
        case medium
        case large
        case xl
    }

    struct Topping {
        let name: String
    }
}

extension Pizza.Size: CaseIterable {}

extension Pizza {
    var isCheesePizza: Bool {
        return toppings.isEmpty
    }
}
