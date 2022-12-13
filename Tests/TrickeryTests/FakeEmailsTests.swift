import GenythingTest
import XCTest
@testable import Trickery

class FakeEmailsTests: XCTestCase {
    func test_personalEmails() {
        testAll(Fake.Emails.personal) { assert, email in
            let parts = email.split(separator: "@")
            assert.equal(parts.count, 2)
        }
    }

    func test_businessEmails() {
        testAll(Fake.Emails.business()) { assert, email in
            let parts = email.split(separator: "@")
            assert.equal(parts.count, 2)
        }
    }
}
