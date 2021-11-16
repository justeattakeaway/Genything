import XCTest
@testable import Trickery

class FakeWebTests: XCTestCase {
    func test_urlScheme() {
        Fake.Web.urlScheme.take().forEach {
            XCTAssertTrue(["https", "http"].contains($0))
        }
    }

    func test_urlDomain() {
        Fake.Web.urlDomain.take().forEach {
            XCTAssertTrue($0.count <= 63)
            XCTAssertTrue($0.count >= 1)
        }
    }

    func test_urlSubdomain() {
        Fake.Web.urlSubdomain.take().forEach {
            XCTAssertTrue($0.count <= 63)
            XCTAssertTrue($0.count >= 1)
        }
    }

    func test_urlString() {
        Fake.Web.urlString.take().forEach {
            let url = URL(string: $0)! // Fatal is only failure condition
            XCTAssertFalse(url.isFileURL)
        }
    }
}
