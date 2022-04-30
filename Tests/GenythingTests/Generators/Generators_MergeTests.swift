import XCTest
@testable import Genything

final class Generators_MergeTests: XCTestCase {
    func test_merging_generators() {
        var curr = 0
        testAllSatisfy(Generators.merge([
            Generators.constant(0),
            Generators.constant(1),
        ])) { value in
            defer {
                curr = (curr + 1) % 2
            }
            return value == curr
        }
    }
}
