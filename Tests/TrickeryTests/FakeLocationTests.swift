import CoreLocation
import GenythingTest
import XCTest
@testable import Trickery

class FakeLocationTests: XCTestCase {
    func test_latitude() {
        TestSuite().testAll(Fake.Locations.latitude) { assert, val in
            assert(val >= -90.0)
            assert(val <= 90.0)
        }
    }

    func test_longitude() {
        TestSuite().testAll(Fake.Locations.longitude) { assert, val in
            assert(val >= -180.0)
            assert(val <= 180.0)
        }
    }

    func test_coordinate() {
        TestSuite().testAllSatisfy(Fake.Locations.coordinate) {
            CLLocationCoordinate2DIsValid($0)
        }
    }
}
