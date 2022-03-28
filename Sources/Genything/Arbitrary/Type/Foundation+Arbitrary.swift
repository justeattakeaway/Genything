import Foundation

// MARK: - Date + Arbitrary

extension Date: Arbitrary {
    /// A generator of arbitrary `Date`s
    public static var arbitrary: AnyGenerator<Date> {
        ArbitraryDateGenerator().eraseToAnyGenerator()
    }
}

private struct ArbitraryDateGenerator: Generator {
    // While `Date(timeIntervalSince1970:)` may take a `TimeInterval` there is a much smaller space where real dates are produced
    let min = Date.distantPast.timeIntervalSince1970
    let max = Date.distantFuture.timeIntervalSince1970

    func next(_ randomSource: RandomSource) -> Date {
        let randomInterval = TimeInterval.random(in: min...max, using: &randomSource.rng)
        return Date(timeIntervalSince1970: randomInterval)
    }
}

// MARK: - UUID + Arbitrary

// extension URL: Arbitrary {
//    public static var arbitrary: Gen<URL> {
//        // TODO: https://datatracker.ietf.org/doc/html/rfc3986
//    }
// }

extension UUID: Arbitrary {
    /// A generator of arbitrary `UUID`s
    public static var arbitrary: AnyGenerator<UUID> = AnyGenerator {
        UUID(bits: ($0.rng.next(), $0.rng.next()), version: 4)
    }
}
