import XCTest
import CoreLocation
@testable import Trickery

class FakeLocationTests: XCTestCase {
    func test_latitude() {
        checkAll(Fake.Locations.latitude) {
            XCTAssertTrue($0 >= -90.0)
            XCTAssertTrue($0 <= 90.0)
        }
    }

    func test_longitude() {
        checkAll(Fake.Locations.longitude) {
            XCTAssertTrue($0 >= -180.0)
            XCTAssertTrue($0 <= 180.0)
        }
    }

    func test_coordinate() {
        checkAll(Fake.Locations.coordinate) {
            CLLocationCoordinate2DIsValid($0)
        }
    }
}
