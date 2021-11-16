import XCTest
@testable import Genything

final internal class GenSampleTests: XCTestCase {
    func test_sample_createsValues_ofSizeCount() {
        let count = 20

        // TODO: can be converted to a proptest

        XCTAssert(String.arbitrary.samples(count: count).count == count)
    }

    func test_sample_createsRandomValueOnEveryCall() {
        let sampled = (0..<5).map { _ in
            String.arbitrary.sample()
        }

        XCTAssertEqual(Set(sampled).count, sampled.count)
    }
}
