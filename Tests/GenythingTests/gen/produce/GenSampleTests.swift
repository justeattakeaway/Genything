import XCTest
import Genything
import GenythingTest

final internal class GenSampleTests: XCTestCase {
    func test_sample_createsValues_ofSizeCount() {
        Gen.from(0...100).assertForAll {
            Gen.constant(()).samples(count: $0).count == $0
        }
    }
}
