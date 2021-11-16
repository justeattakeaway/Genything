import XCTest
import CoreLocation
@testable import Trickery

class FakeLocationTests: XCTestCase {
    func test_latitude() {
        Fake.Locations.latitude.take().forEach {
            XCTAssertTrue($0 >= -90.0)
            XCTAssertTrue($0 <= 90.0)
        }
    }

    func test_longitude() {
        Fake.Locations.longitude.take().forEach {
            XCTAssertTrue($0 >= -180.0)
            XCTAssertTrue($0 <= 180.0)
        }
    }

    func test_coordinate() {
        Fake.Locations.coordinate.take().forEach {
            CLLocationCoordinate2DIsValid($0)
        }
    }
}
