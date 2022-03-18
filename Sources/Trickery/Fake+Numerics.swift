import Foundation
import Genything

extension Fake {
    public enum Numerics {
        public static var digits: AnyGenerator<Int> {
            Generators
                .from(0...9)
                .eraseToAnyGenerator()
        }
    }
}
