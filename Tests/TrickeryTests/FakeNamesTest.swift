import XCTest
@testable import Trickery

class FakeNamesTests: XCTestCase {
    func test_names_first() {
        Fake.Names.first.take().forEach {
            XCTAssertFalse($0.isEmpty)
        }
    }
    
    func test_names_middle() {
        Fake.Names.middle.take().forEach { names in
            let numberOfNames = names.components(separatedBy: .whitespaces).count
            // Some names like "Jo Ann" can have 2 words
            XCTAssertTrue( numberOfNames < 3 )
        }
    }
    
    func test_names_last() {
        Fake.Names.last.take().forEach {
            XCTAssertFalse($0.isEmpty)
        }
    }
    
    func test_names_full() {
        Fake.Names.full.take().forEach { names in
            let numberOfNames = names.components(separatedBy: .whitespaces).count
            XCTAssertTrue( numberOfNames >= 2 && numberOfNames <= 4 )
        }
    }
    
}
