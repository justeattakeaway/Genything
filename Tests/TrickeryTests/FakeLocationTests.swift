import XCTest
import CoreLocation
@testable import Trickery

class FakeLocationTests: XCTestCase {
    func test_latitude() {
        testAll(Fake.Locations.latitude) {
            XCTAssertTrue($0 >= -90.0)
            XCTAssertTrue($0 <= 90.0)
        }
    }

    func test_longitude() {
        testAll(Fake.Locations.longitude) {
            XCTAssertTrue($0 >= -180.0)
            XCTAssertTrue($0 <= 180.0)
        }
    }

    func test_coordinate() {
        testAll(Fake.Locations.coordinate) {
            CLLocationCoordinate2DIsValid($0)
        }
    }
}
