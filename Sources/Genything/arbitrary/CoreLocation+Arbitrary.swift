#if canImport(CoreLocation)
import CoreLocation
import Foundation

extension CLLocationCoordinate2D: Arbitrary {
    /// A generator of arbitrary `CLLocationCoordinate2D`s
    /// `latitude` and `longitude` are bounded by underlying assertions
    public static var arbitrary: AnyGenerator<CLLocationCoordinate2D> {
        Generators.from(-90.0...90).zip(Generators.from(-180.0...180)) { latitude, longitude in
            CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }.eraseToAnyGenerator()
    }
}
#endif
