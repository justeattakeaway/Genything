import Foundation
import Genything

extension Fake {
    public enum Numerics {
        public static var digits: AnyGenerator<Int> {
            (0 ... 9).arbitrary
        }
    }
}
