import GenythingTest
import XCTest
@testable import Trickery

class FakeBusinessNames: XCTestCase {
    func test_businessNames() {
        TestSuite().testAll(Fake.BusinessNames.any) { assert, value in
            let names = value.components(separatedBy: .whitespaces)
            names.forEach {
                assert.equal(true, $0.first?.isUppercase)
            }
        }
    }
}
