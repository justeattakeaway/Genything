import XCTest
@testable import Genything

final internal class GenTakeTests: XCTestCase {
    func test_take() {
        let bucket = [1, 2, 3, 4, 5]
        let generator = Gen.of(bucket)

        let count = 100
        let taken = generator.take(count: count)

        XCTAssertEqual(count, taken.count)

        taken.forEach { val in
            XCTAssertTrue(bucket.contains(val))
        }
    }
}
