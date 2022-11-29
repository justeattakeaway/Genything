import CoreLocation
import GenythingTest
import XCTest
@testable import Trickery

class FakeLocationTests: XCTestCase {
    func test_latitude() {
        testAll(Fake.Locations.latitude) { assert, val in
            assert(val >= -90.0)
            assert(val <= 90.0)
        }
    }

    func test_longitude() {
        testAll(Fake.Locations.longitude) { assert, val in
            assert(val >= -180.0)
            assert(val <= 180.0)
        }
    }

    func test_coordinate() {
        testAllSatisfy(Fake.Locations.coordinate) {
            CLLocationCoordinate2DIsValid($0)
        }
    }
}
