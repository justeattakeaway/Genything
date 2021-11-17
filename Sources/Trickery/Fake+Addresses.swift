import Foundation
import Genything

extension Fake {
    public enum Addresses {
        public static let postalCode: Gen<String> = Gen<String>.replacing(
            "&#& #&#",
            with: [
                (replace: "&", by: Fake.Characters.uppercase.map(String.init)),
                (replace: "#", by: Fake.Characters.digits.map(String.init))
            ]
        )
    }
}
