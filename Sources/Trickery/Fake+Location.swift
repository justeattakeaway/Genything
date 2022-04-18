import CoreLocation
import Foundation
import Genything

extension Fake {
    public enum Locations {
        public static var latitude: AnyGenerator<CLLocationDegrees> {
            CLLocationCoordinate2D.arbitrary
                .map { $0.latitude }
        }

        public static var longitude: AnyGenerator<CLLocationDegrees> {
            CLLocationCoordinate2D.arbitrary
                .map { $0.longitude }
        }

        public static var coordinate: AnyGenerator<CLLocationCoordinate2D> {
            CLLocationCoordinate2D.arbitrary
        }
    }
}
