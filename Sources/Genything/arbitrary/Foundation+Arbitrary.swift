import Foundation

extension Date: Arbitrary {
    public static var arbitrary: Gen<Self> {
        Double.arbitrary.map { Date(timeIntervalSince1970: $0) }
    }
}

//extension URL: Arbitrary {
//    public static var arbitrary: Gen<URL> {
//        // TODO
//    }
//}

extension UUID: Arbitrary {
    public static var arbitrary: Gen<UUID> = Gen {
        UUID(bits: ($0.rng.next(), $0.rng.next()), version: 4)
    }
}
