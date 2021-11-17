import XCTest
@testable import Trickery

class FakeBusinessNames: XCTestCase {
    func test_businessNames() {
        Fake.BusinessNames.any .take().forEach {
            let names = $0.components(separatedBy: .whitespaces)
            names.forEach {
                XCTAssertEqual(true, $0.first?.isUppercase)
            }
        }
    }
}
