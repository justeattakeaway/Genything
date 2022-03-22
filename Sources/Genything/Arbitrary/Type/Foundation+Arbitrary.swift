import Foundation

extension Date: Arbitrary {
    /// A generator of arbitrary `Date`s
    public static var arbitrary: AnyGenerator<Date> {
        Double.arbitrary
            .map { Date(timeIntervalSince1970: $0) }
    }
}

//extension URL: Arbitrary {
//    public static var arbitrary: Gen<URL> {
//        // TODO: https://datatracker.ietf.org/doc/html/rfc3986
//    }
//}

extension UUID: Arbitrary {
    /// A generator of arbitrary `UUID`s
    public static var arbitrary: AnyGenerator<UUID> = AnyGenerator {
        UUID(bits: ($0.rng.next(), $0.rng.next()), version: 4)
    }
}
