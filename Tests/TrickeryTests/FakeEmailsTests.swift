import XCTest
import GenythingTest
@testable import Trickery

class FakeEmailsTests: XCTestCase {
    func test_personalEmails() {
        testAll(Fake.Emails.personal) { email in
            let parts = email.split(separator: "@")
            XCTAssertEqual(parts.count, 2)
        }
    }

    func test_businessEmails() {
        testAll(Fake.Emails.business()) { email in
            let parts = email.split(separator: "@")
            XCTAssertEqual(parts.count, 2)
        }
    }
}
