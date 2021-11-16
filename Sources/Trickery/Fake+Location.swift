import Foundation
import CoreLocation
import Genything

extension Fake {
    public enum Locations {
        public static let latitude: Gen<CLLocationDegrees> = CLLocationCoordinate2D.arbitrary.map { $0.latitude }
        public static let longitude: Gen<CLLocationDegrees> = CLLocationCoordinate2D.arbitrary.map { $0.longitude }
        public static let coordinate: Gen<CLLocationCoordinate2D> = CLLocationCoordinate2D.arbitrary
    }
}
