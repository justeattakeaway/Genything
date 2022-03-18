import XCTest
@testable import Trickery

class FakeBusinessNames: XCTestCase {
    func test_businessNames() {
        checkAll(Fake.BusinessNames.any) {
            let names = $0.components(separatedBy: .whitespaces)
            names.forEach {
                XCTAssertEqual(true, $0.first?.isUppercase)
            }
        }
    }
}
