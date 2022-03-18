import XCTest
import GenythingTest
@testable import Trickery

class FakeWebTests: XCTestCase {
    func test_urlScheme() {
        checkAll(Fake.Web.urlScheme) {
            XCTAssertTrue(["https", "http"].contains($0))
        }
    }

    func test_urlDomain() {
        checkAll(Fake.Web.urlDomain) {
            XCTAssertTrue($0.count <= 63)
            XCTAssertTrue($0.count >= 1)
        }
    }

    func test_urlSubdomain() {
        checkAll(Fake.Web.urlSubdomain) {
            XCTAssertTrue($0.count <= 63)
            XCTAssertTrue($0.count >= 1)
        }
    }

    func test_urlString() {
        checkAll(Fake.Web.urlString) {
            let url = URL(string: $0)! // Fatal is only failure condition
            XCTAssertFalse(url.isFileURL)
        }
    }
}
