import GenythingTest
import XCTest
@testable import Trickery

class FakeWebTests: XCTestCase {
    func test_urlScheme() {
        TestSuite().testAllSatisfy(Fake.Web.urlScheme) {
            ["https", "http"].contains($0)
        }
    }

    func test_urlDomain() {
        TestSuite().testAll(Fake.Web.urlDomain) { assert, value in
            assert(value.count <= 63)
            assert(value.count >= 1)
        }
    }

    func test_urlSubdomain() {
        TestSuite().testAll(Fake.Web.urlSubdomain) { assert, value in
            assert(value.count <= 63)
            assert(value.count >= 1)
        }
    }

    func test_urlString() {
        TestSuite().testAllSatisfy(Fake.Web.urlString) {
            let url = URL(string: $0)! // Fatal is only failure condition
            return !url.isFileURL
        }
    }
}
