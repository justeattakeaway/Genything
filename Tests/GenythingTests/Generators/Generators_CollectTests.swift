import XCTest
@testable import Genything
import GenythingTest

final class Generators_CollectTests: XCTestCase {
    func test_collecting_to_alternate_generators() {
        TestSuite().testAllSatisfy(Generators.collect(
            Generators.constant(0),
            Generators.constant(1)
        )) { values in
            values[0] == 0 && values[1] == 1
        }
    }
}
