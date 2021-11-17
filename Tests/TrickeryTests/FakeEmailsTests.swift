import XCTest
@testable import Trickery

class FakeEmailsTests: XCTestCase {
    func test_personalEmails() {
        Fake.Emails.personal.forEach { email in
            let parts = email.split(separator: "@")
            XCTAssertEqual(parts.count, 2)
        }
    }

    func test_businessEmails() {
        Fake.Emails.business().forEach { email in
            let parts = email.split(separator: "@")
            XCTAssertEqual(parts.count, 2)
        }
    }
}
