import Foundation
import XCTest

func assertAcceptableDelta(total: Int, actual: Int, acceptablePercentDelta: Double) {
    let expected = total / 2
    let delta = abs(expected - actual)

    XCTAssert(
        /// Ensure that we generate nearly 50% of each value
        0...Int(Double(actual) * acceptablePercentDelta) ~= delta,
        "Expected to generate true with ~0.5 probability (± \(acceptablePercentDelta), received ± \(Double(delta) / Double(total))")
}
