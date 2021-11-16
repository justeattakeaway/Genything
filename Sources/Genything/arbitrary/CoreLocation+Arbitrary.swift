#if canImport(CoreLocation)
import CoreLocation
import Foundation

extension CLLocationCoordinate2D: Arbitrary {
    public static var arbitrary: Gen<CLLocationCoordinate2D> {
        Gen.zipWith(Gen.from(-90.0...90), Gen.from(-180.0...180)) { latitude, longitude in
            CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }
    }
}
#endif
