import XCTest
@testable import Genything

final internal class Generator_MapTests: XCTestCase {
    func test_map() {
        let gen1 = [1, 2, 3].arbitrary
        let gen2 = gen1.map { $0 }
        XCTAssertEqual(gen1.take(1000), gen2.take(1000))
    }
}
