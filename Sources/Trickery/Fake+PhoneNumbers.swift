import Foundation
import Genything

extension Fake {
    public enum PhoneNumbers {
        public static let formatted: Gen<String> = Numerics.digits.replacingOccurrences(of: "#", in: "(###) ###-####")
    }
}
