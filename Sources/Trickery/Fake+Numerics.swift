import Foundation
import Genything

extension Fake {
    public enum Numerics {
        public static let digits: Gen<Int> = Gen<Int>.from(0...9)
    }
}
